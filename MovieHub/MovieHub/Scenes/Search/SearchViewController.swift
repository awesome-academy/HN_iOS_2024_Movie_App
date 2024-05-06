//
//  SearchViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 19/04/2024.
//

import UIKit
import Reusable

final class SearchViewController: UIViewController, NibReusable {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    private var movieRepository: MovieRepositoryType = MovieRepository(apiService: APIService.shared)
    private var currentPage = 1
    private  var isFetching = false

    private var dataSource = [Movie]() {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        searchBar.delegate = self
        searchBar.placeholder = "search.placeholder".localized()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: SearchMovieCell.self)
    }
    
    private func searchMovie(name: String, page: Int) {
        loading(true)
        guard !isFetching else { return }
        isFetching = true
        movieRepository.getSearchMovie(query: name, page: page) { [weak self] result in
            guard let self else { return }
            self.isFetching = false
            self.loading(false)
            switch result {
            case .success(let movieResponse):
                self.dataSource += movieResponse.results ?? []
                self.currentPage += 1
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchMovieCell.self)
        cell.configCell(movie: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = dataSource[indexPath.row].id else { return }
        toMovieDetailScreen(movieID: movieID)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource = []
        } else {
            searchMovie(name: searchText, page: currentPage)
        }
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            searchMovie(name: searchBar.text ?? "", page: currentPage)
        }
    }
}

extension SearchViewController {
    func toMovieDetailScreen(movieID: Int) {
        let vc = MovieDetailViewController()
        vc.loadData(movieID: movieID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
