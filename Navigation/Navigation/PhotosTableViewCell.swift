//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 04.05.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private lazy var photosTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        return label
    }()

    private lazy var photoImageView: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var arrowImageView: UIImageView = {
        let image = UIImage(named: "arrow.right")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [photosTitle, photoImageView].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 12

        NSLayoutConstraint.activate([
            photosTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }

}
