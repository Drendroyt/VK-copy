//
//  UICollectionViewExtension.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 07.05.2022.
//

import UIKit

extension UICollectionView {

    open override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    open override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
