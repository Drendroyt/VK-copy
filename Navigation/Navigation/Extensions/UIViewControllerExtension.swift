//
//  UIViewControllerExtension.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 30.04.2022.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
