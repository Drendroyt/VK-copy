//
//  CustomCollectionView.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 07.05.2022.
//

import UIKit

class CustomCollectionView: UICollectionView {

        override func layoutSubviews() {
            super.layoutSubviews()
            if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
                self.invalidateIntrinsicContentSize()
            }
        }
        override var intrinsicContentSize: CGSize {
            return contentSize
        }
    }
