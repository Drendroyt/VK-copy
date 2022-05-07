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

    private lazy var arrowImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.right")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [photosTitle, arrowImageView, photosCollection].forEach { contentView.addSubview($0) }

        let inset: CGFloat = 12

        NSLayoutConstraint.activate([
            photosTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            photosTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset)
        ])

        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: photosTitle.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            photosCollection.topAnchor.constraint(equalTo: photosTitle.bottomAnchor, constant: inset),
            photosCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            photosCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            photosCollection.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25)
        ])
    }

}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 4
        return CGSize(width: width, height: width)
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photosArray[indexPath.item])
        return cell
    }
}
