//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Кирилл Дамковский on 06.03.2022.
//

import UIKit

@IBDesignable
class ProfileView: UIView {

    @IBOutlet weak var photoImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var birthdateLabel: UILabel!

    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var descriptionTextView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }

    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProfileView", bundle: bundle)
        if let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return xibView
        } else {
            return UIView()
        }
    }
}
