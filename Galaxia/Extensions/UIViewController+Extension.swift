//
//  UIViewController+Extension.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

extension UIViewController {
    func toggleSubViews(show: Bool, animatableViews: [UIView], direction: AnimationDirection = .left) {
        if show {
            UIView.animate(withDuration: 0.2) {
                animatableViews.forEach {
                    $0.alpha = 1
                    $0.transform.tx = 0
                }
            }
        } else {
            animatableViews.forEach { 
                $0.alpha = 0
                $0.transform.tx = direction == .left ? -10 : 10
            }
        }
    }
}
