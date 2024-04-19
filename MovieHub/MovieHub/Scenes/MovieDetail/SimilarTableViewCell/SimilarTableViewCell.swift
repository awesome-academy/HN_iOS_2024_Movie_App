//
//  SimilarTableViewCell.swift
//  MovieHub
//
//  Created by Duy Nguyễn on 18/04/2024.
//

import UIKit
import Reusable

final class SimilarTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var recommendTitle: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageView: UIPageControl!
    var tappedSimilar: ((Movie) -> Void)?
    private var dataSource = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        pageView.isUserInteractionEnabled = false
        pageView.currentPageIndicatorTintColor = .white
        pageView.pageIndicatorTintColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: TrailerCell.self)
    }
    
    func configCell(data: [Movie]) {
        self.dataSource = data
        self.pageView.numberOfPages = data.count
    }
}

extension SimilarTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TrailerCell.self)
        cell.configSimilarCell(movie: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedSimilar?(dataSource[indexPath.row])
    }
}

extension SimilarTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insetForSection
    }
}

extension SimilarTableViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageView.currentPage = indexPath.row
    }
}
