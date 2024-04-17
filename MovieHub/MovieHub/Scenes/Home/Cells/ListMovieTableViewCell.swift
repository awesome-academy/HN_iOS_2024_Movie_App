//
//  ListMovieTableViewCell.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/17/24.
//

import UIKit
import Reusable

final class ListMovieTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var collectionView: UICollectionView!
    var tappedMovie: ((Movie) -> ())?

    var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: MovieCollectionViewCell.self)
    }
    
    public func configCell(movies: [Movie]) {
        self.movies = movies
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedMovie?(movies[indexPath.row])
    }
}

extension ListMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 290)
    }
}
