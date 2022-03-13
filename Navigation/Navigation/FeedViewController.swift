//
//  FeedViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 12.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()

    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Лента"
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.postButton)
        self.activateConstrains()
    }

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        button.setTitle("Открыть пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func activateConstrains() {
        self.postButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc private func didTapPostButton() {
        let postVC = PostViewController()
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
}
