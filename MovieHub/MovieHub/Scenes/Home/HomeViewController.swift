//
//  HomeViewController.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import UIKit
import Reusable

final class HomeViewController: UIViewController, NibReusable {

    @IBOutlet private weak var tableView: UITableView!
    
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var upComingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    let dispatchGroup = DispatchGroup()
    var movieRepository: MovieRepositoryType = MovieRepository()
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getMovies()
    }
    
    private func configView() {
        title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: SearchCell.self)
        tableView.register(cellType: ListMovieTableViewCell.self)
        tableView.register(headerFooterViewType: MovieHeader.self)
    }
    
    private func getMovies() {
        dispatchGroup.enter()
        getPopularMovies()
        dispatchGroup.enter()
        getTopratedMovies()
        dispatchGroup.enter()
        getUpcomingMovies()
        dispatchGroup.enter()
        getNowplayingMovies()
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func getPopularMovies() {
        let popularURL = Urls.shared.getPopularUrl()
        movieRepository.getMovies(urlString: popularURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.popularMovies = movieResponse.results ?? []
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getTopratedMovies() {
        let topRatedURL = Urls.shared.getTopRatedUrl()
        movieRepository.getMovies(urlString: topRatedURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.topRatedMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getUpcomingMovies() {
        let upComingURL = Urls.shared.getUpComingUrl()
        movieRepository.getMovies(urlString: upComingURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.upComingMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    private func getNowplayingMovies() {
        let nowPlayingURL = Urls.shared.getNowPlayingUrl()
        movieRepository.getMovies(urlString: nowPlayingURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.nowPlayingMovies = movieResponse.results ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
            self.dispatchGroup.leave()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = HomeSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .search:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchCell.self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ListMovieTableViewCell.self)
            let movies: [Movie]
            switch section {
            case .popular:
                movies = popularMovies
            case .topRated:
                movies = topRatedMovies
            case .upComing:
                movies = upComingMovies
            case .nowPlaying:
                movies = nowPlayingMovies
            default:
                movies = []
            }
            cell.configCell(movies: movies)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 180 : 290
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let movieHeader = tableView.dequeueReusableHeaderFooterView(MovieHeader.self)
            guard let sectionType = HomeSectionType(rawValue: section) else { return nil }
            movieHeader?.configView(title: sectionType.title)
            return movieHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 44
    }
}
