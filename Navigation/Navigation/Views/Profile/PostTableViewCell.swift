//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 01.05.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var indexPath: IndexPath = IndexPath()

    private lazy var postTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(_ post: Post) {
        postTitle.text = post.author
        postImageView.image = UIImage(named: post.image)
        postDescription.text = post.description
        likeLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }

    func setupGestures() {
        let tapPhotoGesture = UITapGestureRecognizer(target: self, action: #selector(countNewView))
        let tapLikesGesture = UITapGestureRecognizer(target: self, action: #selector(countNewLike))
        postImageView.addGestureRecognizer(tapPhotoGesture)
        likeLabel.addGestureRecognizer(tapLikesGesture)
    }

    @objc private func countNewView() {
        postArray[indexPath.row].views += 1
        viewsLabel.text = "Views: \(postArray[indexPath.row].views)"
    }

    @objc private func countNewLike() {
        postArray[indexPath.row].likes += 1
        likeLabel.text = "Likes: \(postArray[indexPath.row].likes)"
    }

    private func layout() {

        [postTitle, postImageView, postDescription, likeLabel, viewsLabel].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 16
        let viewInset: CGFloat = 12

        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            postTitle.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: -viewInset),
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
