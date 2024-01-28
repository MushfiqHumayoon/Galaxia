//
//  UIView+Extension.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

extension UIView {
    // MARK: - View Identifier
    public static func Identifier() -> String {
        return String(describing: self)
    }
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = radius > 0
    }
    func addDottedTopBorder(width: CGFloat, color: UIColor = .darkBackground, lineWidth: CGFloat = 1,
                            dotPattern: [NSNumber] = [4, 8]) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = dotPattern
        borderLayer.fillColor = nil
        borderLayer.lineWidth = lineWidth

        // Create a path for the top border
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        borderLayer.path = path.cgPath

        layer.addSublayer(borderLayer)
    }
}
