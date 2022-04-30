//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 12.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.view.addSubview(profileView)
        self.view.addSubview(mysteriousButton)
        activateConstraints()
        profileView.statusTextField.delegate = self
    }

    override func viewWillLayoutSubviews() {
    }

    private func activateConstraints() {
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            profileView.heightAnchor.constraint(equalToConstant: 220),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mysteriousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mysteriousButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mysteriousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mysteriousButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }

    private lazy var mysteriousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

}
