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
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var leadingAvatar = NSLayoutConstraint()
    var topAvatar = NSLayoutConstraint()
    var widthAvatar = NSLayoutConstraint()
    var heightAvatar = NSLayoutConstraint()
    var centerXAvatar = NSLayoutConstraint()
    var centerYAvatar = NSLayoutConstraint()
    var centerAvatar = NSLayoutConstraint()

    func activateConstraints() {
        [labelStack, statusButton, backView, avatarImage, closeButton].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])

        leadingAvatar = avatarImage.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 16)
        topAvatar = avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        widthAvatar = avatarImage.widthAnchor.constraint(equalToConstant: 100)
        heightAvatar = avatarImage.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            leadingAvatar,
            topAvatar,
            widthAvatar,
            heightAvatar
        ])

        [nameLabel, statusLabel, statusTextField].forEach { labelStack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (16 + 100 + 10)),
            labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            statusButton.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupGestures() {
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatarGesture))
        avatarImage.addGestureRecognizer(tapAvatarGesture)
    }

    @objc private func tapAvatarGesture() {
        UIView.animate(withDuration: 0.5) {
                NSLayoutConstraint.deactivate([
                    self.topAvatar,
                    self.leadingAvatar,
                    self.widthAvatar,
                    self.heightAvatar
                ])

                self.centerXAvatar = self.avatarImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                self.centerYAvatar = self.avatarImage.centerYAnchor.constraint(equalTo: self.superview?.centerYAnchor ?? self.centerYAnchor)
                self.widthAvatar = self.avatarImage.widthAnchor.constraint(equalTo: self.widthAnchor)
                self.heightAvatar = self.avatarImage.heightAnchor.constraint(equalTo: self.widthAnchor)

                NSLayoutConstraint.activate([
                    self.centerXAvatar,
                    self.centerYAvatar,
                    self.widthAvatar,
                    self.heightAvatar
                ])

                self.backView.alpha = 0.5
                self.avatarImage.layer.cornerRadius = 0
                self.layoutIfNeeded()
            } completion: { _ in
                UIView.animate(withDuration: 0.3,
                               delay: 0) {
                    self.closeButton.alpha = 1
                }
            }
        }

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.alpha = 0
        return button
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
        avatarView.clipsToBounds = true
        avatarView.layer.borderWidth = 3
        avatarView.layer.cornerRadius = 50
        avatarView.layer.borderColor = .init(red: 255, green: 255, blue: 255, alpha: 1)
        avatarView.isUserInteractionEnabled = true
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

    @objc private func tapCloseButton() {
        self.closeButton.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0) {
                NSLayoutConstraint.deactivate([
                    self.centerXAvatar,
                    self.centerYAvatar,
                    self.widthAvatar,
                    self.heightAvatar
                ])

            self.leadingAvatar = self.avatarImage.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 16)
            self.topAvatar = self.avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
            self.widthAvatar = self.avatarImage.widthAnchor.constraint(equalToConstant: 100)
            self.heightAvatar = self.avatarImage.heightAnchor.constraint(equalToConstant: 100)

                NSLayoutConstraint.activate([
                    self.topAvatar,
                    self.leadingAvatar,
                    self.widthAvatar,
                    self.heightAvatar
                ])

                self.backView.alpha = 0
                self.avatarImage.layer.cornerRadius = 50
                self.layoutIfNeeded()
            }
        }
}
