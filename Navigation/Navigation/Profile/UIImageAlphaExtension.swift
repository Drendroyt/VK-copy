//
//  UIImageAlphaExtension.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 30.04.2022.
//

import UIKit

extension UIImage {
    func alpha (_ alphaValue: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alphaValue)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

