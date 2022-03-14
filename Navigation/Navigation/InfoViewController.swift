//
//  InfoViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 13.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGreen
        self.view.addSubview(postButton)
        self.activateConstrains()
    }

    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .systemYellow
        button.setTitle("Показать алерт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func activateConstrains() {
        self.postButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc private func didTapAlertButton() {
        let alert = UIAlertController(title: "Внимание", message: "Вам необходимо выбрать", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Вывод в консоль", style: .default, handler: { action in print("user taped confirm button")} )
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: { action in self.dismiss(animated: true, completion: nil)})
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
