//
//  ActorViewController.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 23/04/2024.
//

import UIKit
import Reusable

final class ActorViewController: UIViewController, NibReusable {

    @IBOutlet private weak var tableView: UITableView!
    
    private var movieRepository: MovieRepositoryType = MovieRepository()
    var idActor: Int?
    private var actor = Actor()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getActorDetail()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: ActorInfoCell.self)
        tableView.register(cellType: ActorMovieCell.self)
    }
    
    private func getActorDetail() {
        guard let id = idActor else { return }
        movieRepository.getActorDetail(id: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let actor):
                DispatchQueue.main.async {
                    self.actor = actor
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
        }
    }
}


extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ActorSectionType.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ActorSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .info:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ActorInfoCell.self)
            cell.setContentForCell(actor: actor)
            return cell
            
        case .movies:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ActorMovieCell.self)
            cell.configCell(movies: actor.movieCredits?.movies ?? [])
            cell.tappedMovie = { [weak self] movie in
                guard let self, let movieID = movie.id else { return }
                self.toMovieDetailScreen(movieID: movieID)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ActorViewController {
    func toMovieDetailScreen(movieID: Int) {
        let vc = MovieDetailViewController()
        vc.loadData(movieID: movieID)
        navigationController?.pushViewController(vc, animated: true)
    }
}
