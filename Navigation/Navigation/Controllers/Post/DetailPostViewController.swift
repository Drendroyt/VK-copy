//
//  DetailPostViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 21.05.2022.
//

import UIKit

class DetailPostViewController: UIViewController {

    var indexPath: IndexPath = IndexPath()
    weak var delegate: PostTableViewCell?

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

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        view.backgroundColor = .white
        setupGestures()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = postArray[indexPath.row].author
    }

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    func setupView(_ post: Post) {
        postImageView.image = UIImage(named: post.image)
        postDescription.text = post.description
        likeLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }

    func setupGestures() {
        let tapLikesGesture = UITapGestureRecognizer(target: self, action: #selector(countNewLike))
        likeLabel.addGestureRecognizer(tapLikesGesture)
    }

    @objc private func countNewLike() {
        postArray[indexPath.row].likes += 1
        likeLabel.text = "Likes: \(postArray[indexPath.row].likes)"
        if let delegate = delegate {
            delegate.likeLabel.text = "Likes: \(postArray[indexPath.row].likes)"
            print("update count")
        }
    }

    private func layout() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [postImageView, postDescription, likeLabel, viewsLabel].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16

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
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: postDescription.topAnchor, constant: -inset),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            postDescription.bottomAnchor.constraint(equalTo: likeLabel.topAnchor, constant: -inset),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            viewsLabel.topAnchor.constraint(equalTo: likeLabel.topAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

}
