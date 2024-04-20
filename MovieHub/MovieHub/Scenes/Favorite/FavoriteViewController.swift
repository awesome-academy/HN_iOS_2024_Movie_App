//
//  FavoriteViewController.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import UIKit
import Reusable

final class FavoriteViewController: UIViewController, NibReusable {

    @IBOutlet private weak var tableView: UITableView!
    private var movieRepository: MovieRepositoryType = MovieRepository()

    private var dataSource = [FavoriteMovie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        prepareDataSource()
        NotificationCenter.default.addObserver(self, selector: #selector(handleDataChange),
                                               name: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.NSManagedObjectContextDidSave,
                                                  object: nil)
    }
    
    @objc private func handleDataChange() {
        prepareDataSource()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchMovieCell.self)
    }
    
    private func prepareDataSource() {
        movieRepository.fetchFavoriteMovies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favoriteMovies):
                DispatchQueue.main.async {
                    self.dataSource = favoriteMovies
                }
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchMovieCell.self)
        cell.configCell(movie: dataSource[indexPath.row])
        return cell
    }
}
