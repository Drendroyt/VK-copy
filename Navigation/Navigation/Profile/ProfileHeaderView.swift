//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 20.03.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        activateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var leadingAvatar = NSLayoutConstraint()
    var topAvatar = NSLayoutConstraint()
    var trailingAvatar = NSLayoutConstraint()
    var bottomAvatar = NSLayoutConstraint()

    func activateConstraints() {

        contentView.addSubview(contentStack)
        contentView.addSubview(statusButton)
        backImageView.addSubview(avatarImage)
        contentStack.addArrangedSubview(backImageView)
        contentStack.addArrangedSubview(labelStack)
        labelStack.addArrangedSubview(nameLabel)
        labelStack.addArrangedSubview(statusLabel)
        labelStack.addArrangedSubview(statusTextField)

        contentStack.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 16).isActive = true
        contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        contentStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        statusButton.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 16).isActive = true
        statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        topAvatar = avatarImage.topAnchor.constraint(equalTo: backImageView.topAnchor)
        leadingAvatar = avatarImage.leadingAnchor.constraint(equalTo: backImageView.leadingAnchor)
        trailingAvatar = avatarImage.trailingAnchor.constraint(equalTo: backImageView.trailingAnchor)
        bottomAvatar = avatarImage.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor)

        NSLayoutConstraint.activate([
            topAvatar,
            leadingAvatar,
            trailingAvatar,
            bottomAvatar
        ])

    }

    private lazy var backImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
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
        label.text = "Waiting for something"
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
        stackView.distribution = .fillEqually
        return stackView
    }()

     lazy var avatarImage: UIImageView = {
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
        button.setTitle("Set status", for: .normal)
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
        print("Статус до изменения: \(statusLabel.text ?? "Статус пустой")")
        statusLabel.text = statusText
        print("Статус после изменения: \(statusLabel.text ?? "Статус пустой")")
        self.endEditing(true)
    }

    private var statusText: String?

    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.placeholder = "Set your status..."
        return textField
    }()

    @objc private func statusTextChanged() {
        let newStatusText = statusTextField.text
        statusText = newStatusText
    }
}
