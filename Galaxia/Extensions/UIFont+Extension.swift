//
//  UIFont+Extension.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

extension UIFont {
    // MARK: - Extra Light : 200
    class func fontExtraLight(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontExtraLight, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    // MARK: - Light : 300
    class func fontLight(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontLight, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    // MARK: - Regular : 400
    class func fontRegular(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontRegular, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    // MARK: - Semi Bold : 600
    class func fontSemiBold(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontSemiBold, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
    // MARK: - Bold : 700
    class func fontBold(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontBold, size: size) ?? UIFont.boldSystemFont(ofSize: size)
        return font
    }
    // MARK: - Black : 900
    class func fontBlack(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: AppFont.fontBlack, size: size) ?? UIFont.boldSystemFont(ofSize: size)
        return font
    }
}
