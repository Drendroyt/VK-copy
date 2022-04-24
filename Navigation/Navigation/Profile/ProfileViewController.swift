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
        profileView.statusTextField.delegate = self
    }

    override func viewWillLayoutSubviews() {
        self.view.addSubview(self.profileView)
        profileView.activateConstraints()
        profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        profileView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
