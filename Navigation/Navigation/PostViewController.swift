//
//  PostViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 12.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Пост"
    }

    private func setupView() {
        self.view.backgroundColor = .systemGreen
    }

}
