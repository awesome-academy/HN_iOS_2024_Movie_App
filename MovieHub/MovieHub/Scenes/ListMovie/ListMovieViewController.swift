//
//  ListMovieViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable

final class ListMovieViewController: UIViewController, NibReusable {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var currentPage = 1
    private var isFetching = false
    var category: String = ""
    var titleString: String = ""
    private var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var movieRepository: MovieRepositoryType = MovieRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        prepareDatasource()
    }
    
    private func configView() {
        titleLabel.text = titleString
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MovieCollectionViewCell.self)
    }
    
    private func prepareDatasource() {
        guard !isFetching else { return }
        isFetching = true
        let categoryURL = Urls.shared.getListMovie(categories: category, page: currentPage)
        movieRepository.getMovies(urlString: categoryURL) { [weak self] result in
            guard let self else { return }
            self.isFetching = false
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async {
                    self.movies += movieResponse.results ?? []
                    self.currentPage += 1
                }
            case .failure(let error):
                switch error {
                case let AppError.normalError(message):
                    self.showError(message: message)
                default:
                    self.showError(message: error.localizedDescription)
                }
            }
        }
    }
}

extension ListMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.loadData(movie: movies[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListMovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constants.WIDTH_SCREEN - 30)/3, height: 290)
    }
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return Constants.minLineSpacing
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return Constants.minLineSpacing
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero,
                            left: Constants.minLineSpacing,
                            bottom: .zero,
                            right: Constants.minLineSpacing)
    }
}

extension ListMovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            prepareDatasource()
        }
    }
}
