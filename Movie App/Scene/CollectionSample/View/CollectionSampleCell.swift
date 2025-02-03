//
//  CollectionSampleCell.swift
//  Movie App
//
//  Created by Sajjad on 2/3/25.
//

import UIKit

final class CollectionSampleCell: UICollectionViewCell {
    private enum Constants {
        static let cornerRadius = 12.0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }

    func config(with model: CollectionSampleCellViewModel) {
        contentView.backgroundColor = model.color
    }
}

struct CollectionSampleCellViewModel: Hashable {
    let id: String
    let color: UIColor?
}
