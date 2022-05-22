//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 07.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var photoTopAcnhor = NSLayoutConstraint()
    var photoLeadingAnchor = NSLayoutConstraint()
    var photoTrailingAnchor = NSLayoutConstraint()
    var photoBottomAnchor = NSLayoutConstraint()

    weak var delegate: PhotosCollectionViewCell?

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

    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
            cell.photoView.removeFromSuperview()
            self.view.addSubview(cell.photoView)

            photoTopAcnhor = cell.photoView.topAnchor.constraint(equalTo: cell.topAnchor)
            photoLeadingAnchor = cell.photoView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
            photoTrailingAnchor = cell.photoView.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
            photoBottomAnchor = cell.photoView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)

            NSLayoutConstraint.activate([
                photoTopAcnhor,
                photoLeadingAnchor,
                photoTrailingAnchor,
                photoBottomAnchor
            ])
            photosCollection.isScrollEnabled = false
            photosCollection.allowsSelection = false
            view.layoutIfNeeded()

            UIView.animate(withDuration: 0.5) {

                NSLayoutConstraint.deactivate([
                    self.photoTopAcnhor,
                    self.photoLeadingAnchor,
                    self.photoTrailingAnchor,
                    self.photoBottomAnchor
                ])

                self.photoTopAcnhor = cell.photoView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
                self.photoLeadingAnchor = cell.photoView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
                self.photoTrailingAnchor = cell.photoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
                self.photoBottomAnchor = cell.photoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

                NSLayoutConstraint.activate([
                    self.photoTopAcnhor,
                    self.photoLeadingAnchor,
                    self.photoTrailingAnchor,
                    self.photoBottomAnchor
                ])

                self.backView.alpha = 0.5
                self.view.layoutIfNeeded()

            } completion: { _ in
                self.navigationItem.rightBarButtonItem = {
                    let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(self.tapCloseButton))
                    self.delegate = cell
                    return backButton
                }()
            }
        }
    }

    @objc func tapCloseButton() {
        print(#function)
        if let photoView = delegate?.photoView, let contentView = delegate?.contentView, let delegate = delegate {
            photoView.removeFromSuperview()
            contentView.addSubview(photoView)
            photosCollection.bringSubviewToFront(delegate)

            photoTopAcnhor = photoView.widthAnchor.constraint(equalTo: view.widthAnchor)
            photoLeadingAnchor = photoView.heightAnchor.constraint(equalTo: view.widthAnchor)
            photoTrailingAnchor = photoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            photoBottomAnchor = photoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

            NSLayoutConstraint.activate([
                photoTopAcnhor,
                photoLeadingAnchor,
                photoTrailingAnchor,
                photoBottomAnchor
            ])

            self.backView.alpha = 0
            view.layoutIfNeeded()

            UIView.animate(withDuration: 0.5) {

                NSLayoutConstraint.deactivate([
                    self.photoTopAcnhor,
                    self.photoLeadingAnchor,
                    self.photoTrailingAnchor,
                    self.photoBottomAnchor
                ])

                NSLayoutConstraint.activate([
                    photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])

                self.view.layoutIfNeeded()

            } completion: { _ in
                self.photosCollection.isScrollEnabled = true
                self.photosCollection.allowsSelection = true
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        view.addSubview(photosCollection)
        view.addSubview(backView)

        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            photosCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photosCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photosCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
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
