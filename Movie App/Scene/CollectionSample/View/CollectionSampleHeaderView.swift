//
//  CollectionSampleHeaderView.swift
//  Movie App
//
//  Created by Sajjad on 2/3/25.
//

import UIKit

final class CollectionSampleHeader: UICollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .colorText
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .colorBackground
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func config(with model: CollectionSampleHeaderViewModel) {
        switch model.headerType {
        case .none:
            break
        case .header(let title):
            titleLabel.text = title
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

struct CollectionSampleHeaderViewModel: Hashable {
    enum HeaderType: Hashable {
        case none
        case header(title: String)
    }
    let id: String
    let headerType: HeaderType
}
