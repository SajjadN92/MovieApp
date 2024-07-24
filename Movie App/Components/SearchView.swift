//
//  SearchView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit
import Combine

final class SearchView: UIView {

    private enum Constants {
        static let searchIcon = "magnifyingglass"
        static let margin = 24.0
        static let roundedViewHeight = 35.0
        static let itemMargin = 8.0
    }

    private let textSubject = PassthroughSubject<String, Never>()
    var textPublisher: AnyPublisher<String, Never> {
        textSubject.eraseToAnyPublisher()
    }

    private lazy var roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorBackground
        return view
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = Fonts.Body1.medium
        textField.textColor = .colorText
        textField.placeholder = Localized.search
        textField.delegate = self
        return textField
    }()

    private lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .colorText
        imageView.image = UIImage(systemName: Constants.searchIcon)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        roundedView.layer.cornerRadius = roundedView.frame.height / 2
    }

    private func setupView() {
        backgroundColor = .colorSecondaryBackground

        addSubview(roundedView)
        roundedView.addSubviews(searchTextField, searchIcon)
        NSLayoutConstraint.activate([
            roundedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin),
            roundedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin),
            roundedView.centerYAnchor.constraint(equalTo: centerYAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: Constants.roundedViewHeight),

            searchIcon.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: Constants.itemMargin),
            searchIcon.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            searchIcon.heightAnchor.constraint(equalTo: roundedView.heightAnchor, multiplier: 0.6),
            searchIcon.widthAnchor.constraint(equalTo: searchIcon.heightAnchor),

            searchTextField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: Constants.itemMargin),
            searchTextField.topAnchor.constraint(equalTo: roundedView.topAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -Constants.margin)
        ])
    }
}

extension SearchView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?
            .replacingCharacters(in: range, with: string) ?? ""
        textSubject.send(text)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
