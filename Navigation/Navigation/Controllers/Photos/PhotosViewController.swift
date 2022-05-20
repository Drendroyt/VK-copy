//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 07.05.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var leadingPhoto = NSLayoutConstraint()
    var topPhoto = NSLayoutConstraint()
    var widthPhoto = NSLayoutConstraint()
    var heightPhoto = NSLayoutConstraint()
    var centerXPhoto = NSLayoutConstraint()
    var centerYPhoto = NSLayoutConstraint()
    var centerPhoto = NSLayoutConstraint()
    var leadingBackPhoto = NSLayoutConstraint()
    var topBackPhoto = NSLayoutConstraint()
    var widthBackPhoto = NSLayoutConstraint()
    var heightBackPhoto = NSLayoutConstraint()
    var centerXBackPhoto = NSLayoutConstraint()
    var centerYBackPhoto = NSLayoutConstraint()
    var centerBackPhoto = NSLayoutConstraint()


    lazy var zoomPhotoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

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

    private func animatePhoto() {
        print(#function)
    }

    private func tapPhotoGesture(cell: PhotosCollectionViewCell?) {
        print(#function)


//        view.addSubview(photoView)

//        if let cellFrame = cellFrame {
//            self.widthPhoto = photoView.widthAnchor.constraint(equalToConstant: cellFrame.width)
//            self.heightPhoto = photoView.heightAnchor.constraint(equalToConstant: cellFrame.height)
//            self.centerXPhoto = photoView.centerXAnchor.constraint(e)
//            self.centerYPhoto = photoView.centerYAnchor.constraint(equalTo: cellFrame.midY)
//
//            NSLayoutXAxisAnchor()
//
//        }
//
//        NSLayoutConstraint.activate([
//            self.widthPhoto,
//            self.heightPhoto,
//            self.centerXPhoto,
//            self.centerYPhoto
//        ])
//
//        animatePhoto()
        if let cell = cell {
            lazy var backView: UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .white
                return view
            }()

//            lazy var zoomPhotoView: UIImageView = {
//                let view = UIImageView(image: cell.photoView.image)
//                view.translatesAutoresizingMaskIntoConstraints = false
//                view.clipsToBounds = true
//                return view
//            }()

            zoomPhotoView.image = cell.photoView.image

            //добавить фото на беквью-


            self.topBackPhoto = backView.topAnchor.constraint(equalTo: cell.topAnchor)
            self.leadingBackPhoto = backView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
            self.widthBackPhoto = backView.widthAnchor.constraint(equalToConstant: cell.bounds.width)
            self.heightBackPhoto = backView.heightAnchor.constraint(equalToConstant: cell.bounds.height)

            self.topPhoto = zoomPhotoView.topAnchor.constraint(equalTo: cell.topAnchor)
            self.leadingPhoto = zoomPhotoView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
            self.widthPhoto = zoomPhotoView.widthAnchor.constraint(equalToConstant: cell.bounds.width)
            self.heightPhoto = zoomPhotoView.heightAnchor.constraint(equalToConstant: cell.bounds.height)

            NSLayoutConstraint.activate([
//                topBackPhoto,
//                leadingBackPhoto,
//                widthBackPhoto,
//                heightBackPhoto,
                topPhoto,
                leadingPhoto,
                widthPhoto,
                heightPhoto
            ])

            UIView.animate(withDuration: 3.5) {
                NSLayoutConstraint.deactivate([
//                    self.topBackPhoto,
//                    self.leadingBackPhoto,
//                    self.widthBackPhoto,
//                    self.heightBackPhoto,
                    self.topPhoto,
                    self.leadingPhoto,
                    self.widthPhoto,
                    self.heightPhoto
                ])

                self.topBackPhoto = backView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
                self.leadingBackPhoto = backView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
                self.widthBackPhoto = backView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
                self.heightBackPhoto = backView.heightAnchor.constraint(equalToConstant: self.view.bounds.height)

                self.centerXPhoto = self.zoomPhotoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor )
                self.centerYPhoto = self.zoomPhotoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
                self.widthPhoto = self.zoomPhotoView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
                self.heightPhoto = self.zoomPhotoView.heightAnchor.constraint(equalToConstant: self.view.bounds.width)

                NSLayoutConstraint.activate([
//                    self.topBackPhoto,
//                    self.leadingBackPhoto,
//                    self.widthBackPhoto,
//                    self.heightBackPhoto,
                    self.centerXPhoto,
                    self.centerYPhoto,
                    self.widthPhoto,
                    self.heightPhoto
                ])

                self.view.layoutIfNeeded()

            } completion: { _ in
                //
            }
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func layout() {
        view.addSubview(photosCollection)
        [zoomPhotoView].forEach { view.addSubview($0) }

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
        print("tap")
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
        //setupGestures(cell: cell)
        return cell
    }
}
