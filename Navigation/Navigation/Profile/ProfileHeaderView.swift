//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 20.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    override init(frame: CGRect) {
        super .init(frame: frame)
        self.addSubview(contentStack)
        self.addSubview(statusButton)
        contentStack.addArrangedSubview(avatarImage)
        contentStack.addArrangedSubview(labelStack)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(statusLabel)
    }

    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }

    func activateConstraints() {
            contentStack.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 16).isActive = true
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
            contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
            statusButton.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 16).isActive = true
            statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marty"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Back to future"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImage(named: "marty")
        let avatarView = UIImageView(image: avatarImage)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarView.clipsToBounds = true
        avatarView.layer.borderWidth = 3
        avatarView.layer.cornerRadius = 50
        avatarView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        return avatarView
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.backgroundColor = .blue
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.shadowOpacity = 0.7
        return button
    }()

    @objc private func didTapStatusButton() {
        print(statusLabel.text ?? "Статус пустой")
    }

}
