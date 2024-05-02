//
//  MovieDetailViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable
import SafariServices

final class MovieDetailViewController: UIViewController, NibReusable {

    @IBOutlet private weak var tableView: UITableView!
    private var movie: Movie? {
        didSet {
            tableView.reloadData()
        }
    }
    private var movieRepository: MovieRepositoryType = MovieRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: MovieDetailInfoCell.self)
        tableView.register(cellType: CastTableViewCell.self)
        tableView.register(cellType: SimilarTableViewCell.self)
    }
    
    func loadData(movieID: Int) {
         getMovieDetail(id: movieID)
    }
    
    private func getMovieDetail(id: Int) {
        loading(true)
        movieRepository.getMovieDetail(id: id) { [weak self] result in
            guard let self else { return }
            self.loading(false)
            switch result {
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self.movie = movieDetail
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                case AppError.noInternet:
                    self.showError(title: AppError.noInternet.description)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieSectionType.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MovieSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .info:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieDetailInfoCell.self)
            
            guard let movieDetail = movie else { return UITableViewCell() }
            guard let movieID = movieDetail.id else { return UITableViewCell() }
            let isFavorite = movieRepository.isMovieInFavorites(movieID: movieID)
            cell.configCell(movie: movieDetail, isFavorite: isFavorite)
            cell.tappedFavorite = { [weak self] movie in
                guard let self else { return }
                if movieRepository.isMovieInFavorites(movieID: movieID) {
                    movieRepository.deleteMovieFromFavorites(movieID: movieID) { result in
                        switch result {
                        case .success:
                            DispatchQueue.main.async {
                                self.showSuccess(message: "movie.remove".localized())
                                cell.updateFavoriteButtonImage(isFavorite: false)
     
                            }
                        case .failure(let error):
                            self.showError(message: error.localizedDescription)
                        }
                    }
                } else {
                    movieRepository.saveMovieToFavorites(movie: movie) { result in
                        switch result {
                        case .success:
                            DispatchQueue.main.async {
                                cell.updateFavoriteButtonImage(isFavorite: true)
                                self.showSuccess(message: "movie.add".localized())
                            }
                        case .failure(let error):
                            self.showError(message: error.localizedDescription)
                        }
                    }
                }
            }
            cell.tappedPlay = { [weak self] movie in
                guard let self, let movieKey = movie.videos?.results?.first?.key else { return }
                let trailerUrlString = Urls.shared.getTrailerUrl(key: movieKey)
                self.presentSafariViewController(with: trailerUrlString)
            }
            cell.selectionStyle = .none
            return cell
            
        case .cast:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CastTableViewCell.self)
            guard let movieDetail = movie else { return UITableViewCell() }
            cell.prepareDatasource(data: movieDetail.credits?.cast ?? [])
            cell.tappedCast = { [weak self] cast in
                guard let self else { return }
                self.toActorDetailScreen(cast: cast)
            }
            cell.selectionStyle = .none
            return cell
            
        case .similar:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SimilarTableViewCell.self)
            guard let movieDetail = movie else { return UITableViewCell() }
            cell.configCell(data: movieDetail.similar?.results ?? [])
            cell.tappedSimilar = { [weak self] movie in
                guard let self else { return }
                guard let movieID = movie.id else { return }
                self.toMovieDetailScreen(movieID: movieID)
            }
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailViewController {
    private func toMovieDetailScreen(movieID: Int) {
        let vc = MovieDetailViewController()
        vc.loadData(movieID: movieID)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func toActorDetailScreen(cast: Cast) {
        let vc = ActorViewController()
        vc.idActor = cast.id
        navigationController?.pushViewController(vc, animated: true)
    }
}
