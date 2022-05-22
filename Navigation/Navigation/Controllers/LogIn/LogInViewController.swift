//
//  LogInViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 29.04.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private let nc = NotificationCenter.default

    private lazy var inputAlertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ваш пароль слишком короткий"
        label.textColor = .red
        return label
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
      }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()

    private lazy var logoImage: UIImageView = {
        let logoImage = UIImage(named: "VKLogo")
        let imageView = UIImageView(image: logoImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var loginInpunt: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.placeholder = "Email or phone"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "logInButtonColor")
        textField.autocapitalizationType = .none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(refreshTextField), for: .editingDidBegin)
        return textField
    }()

    private lazy var passwordInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(refreshTextField), for: .editingDidBegin)
        return textField
    }()

    @objc func refreshTextField(textField: UITextField) {
        textField.attributedPlaceholder = nil
        switch textField {
        case passwordInput:
            textField.placeholder = "Password"
            inputAlertLabel.removeFromSuperview()
        case loginInpunt:
            textField.placeholder = "Email or phone"
        default:
            textField.placeholder = nil
        }
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }

    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        let backgroundImage = UIImage(named: "bluePixel")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(backgroundImage?.alpha(1), for: .normal)
        button.setBackgroundImage(backgroundImage?.alpha(0.8), for: .selected)
        button.setBackgroundImage(backgroundImage?.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(backgroundImage?.alpha(0.8), for: .disabled)
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()

    @objc private func logIn() {
        let result = inputValidation()
        if result {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: false)
            view.endEditing(true)
        } else {
            view.endEditing(true)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput.delegate = self
        loginInpunt.delegate = self
        setupNavigationBar()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: false)
        }
    }

    @objc private func keyboardHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        let inset: CGFloat = 16

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [loginInpunt, passwordInput].forEach { inputStackView.addArrangedSubview($0) }

        [logoImage, inputStackView, logInButton].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            inputStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            passwordInput.heightAnchor.constraint(equalToConstant: 50),
            loginInpunt.heightAnchor.constraint(equalToConstant: 50),
            inputStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            inputStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            logInButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: inset),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func inputValidation() -> Bool {
        var result: Bool = true
        let minPasswordLength = 6
        let correctLogin = "Drendroyt@mail.ru"
        let correctPassword = "123456"

        if passwordInput.hasText {
            if passwordInput.text!.count < minPasswordLength {
                passwordInput.layer.borderColor = UIColor.red.cgColor
                inputStackView.addArrangedSubview(inputAlertLabel)
                result = false
            }
        } else {
            passwordInput.layer.borderColor = UIColor.red.cgColor
            passwordInput.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            result = false
        }

        if loginInpunt.hasText {
            // валидация email
        } else {
            loginInpunt.layer.borderColor = UIColor.red.cgColor
            loginInpunt.attributedPlaceholder = NSAttributedString(string: "Введите логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            result = false
        }

        if result, (loginInpunt.text != correctLogin || passwordInput.text != correctPassword) {
            lazy var logInAlert: UIAlertController = {
                let alert = UIAlertController(
                    title: "Внимание",
                    message: "Вы ввели некорретный логин/пароль. Попробуйте еще раз",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "ОК",
                                              style: .cancel,
                                              handler: {_ in
                    self.dismiss(animated: true, completion: nil)
                }))
                return alert
            }()

            self.present(logInAlert, animated: true)
            result = false
        }

        return result
    }

}

