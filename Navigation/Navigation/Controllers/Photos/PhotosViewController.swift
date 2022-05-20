//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 07.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    private lazy var photosCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Photo Gallery"
    }

    private func tapPhotoGesture(cell: PhotosCollectionViewCell?) {
        print(#function)
        if let cell = cell {
            photosCollection.bringSubviewToFront(cell)
            view.layoutIfNeeded()
            UIView.animate(withDuration: 1) {

                cell.photoView.constraints.forEach { $0.isActive = false }

                var photoXCenter = cell.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                var photoYCenter = cell.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                var photoWidth = cell.photoView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
                var photoHeight = cell.photoView.heightAnchor.constraint(equalToConstant: self.view.bounds.width)

                NSLayoutConstraint.activate([
                    photoXCenter,
                    photoYCenter,
                    photoWidth,
                    photoHeight
                ])

                self.view.layoutIfNeeded()

            } completion: { _ in
                self.navigationItem.rightBarButtonItem = {
                    let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.tapCloseButton))
                    return backButton
                }()
            }
        }
    }

    @objc func tapCloseButton() {
        print(#function)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        view.addSubview(photosCollection)

        NSLayoutConstraint.activate([
            photosCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        tapPhotoGesture(cell: cell)

    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photosArray[indexPath.item])
        cell.isUserInteractionEnabled = true
        return cell
    }
}
