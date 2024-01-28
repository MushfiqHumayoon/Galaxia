//
//  SearchTextField.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class SearchTextField: UITextField {

    // Callback closures for icon taps
    var onLeftIconTap: tapHandler?
    var onRightIconTap: tapHandler?

    // Function to set icons
    func setIcons(leftIcon: UIImage?, rightIcon: UIImage?, color: UIColor = .onSurfaceLight) {
        if let leftIcon = leftIcon {
            let leftButton = UIButton(type: .custom)
            leftButton.setImage(leftIcon.withRenderingMode(.alwaysTemplate), for: .normal)
            leftButton.tintColor = color
            leftButton.imageView?.contentMode = .scaleAspectFit
            leftButton.addTarget(self, action: #selector(leftIconTapped), for: .touchUpInside)
            leftView = leftButton
            leftViewMode = .always
//            leftButton.frame = CGRect(x: 20, y: 0, width: 30, height: 30)
            let leftPadding: CGFloat = 10
            leftButton.frame = CGRect(x: 0, y: 0, width: leftIcon.size.width + leftPadding, height: leftIcon.size.height)
            leftButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
                    
        }

        if let rightIcon = rightIcon {
            let rightButton = UIButton(type: .custom)
            rightButton.setImage(rightIcon, for: .normal)
            rightButton.imageView?.contentMode = .scaleAspectFit
            rightButton.addTarget(self, action: #selector(rightIconTapped), for: .touchUpInside)
            rightView = rightButton
            rightViewMode = .always
//            rightButton.frame = CGRect(x: -10, y: 0, width: 30, height: 30)
            let rightPadding: CGFloat = 12
            rightButton.frame = CGRect(x: 0, y: 0, width: rightIcon.size.width + rightPadding, height: rightIcon.size.height)
            rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightPadding)
        }
    }

    @objc private func leftIconTapped() {
        onLeftIconTap?()
    }

    @objc private func rightIconTapped() {
        onRightIconTap?()
    }

    // Function to set placeholder color
    func setPlaceholder(text: String, color: UIColor) {
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor: color]
        attributedPlaceholder = NSAttributedString(string: text, attributes: placeholderAttributes)
    }
}
