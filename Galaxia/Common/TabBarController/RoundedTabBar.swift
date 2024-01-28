//
//  RoundedTabBar.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class RoundedTabBar: UITabBar {
    // MARK: - Properties
    private let dotIndicator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        makeBackgroundTransparent()
        setupSelectionIndicator()
    }
    override func layoutIfNeeded() {
        makeBackgroundTransparent()
    }
    fileprivate func makeBackgroundTransparent() {
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.backgroundColor = .clear
    }
    
    fileprivate func setupSelectionIndicator() {
        dotIndicator.layer.cornerRadius = 3
        dotIndicator.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
        addSubview(dotIndicator)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0, green: 0.308, blue: 0.771, alpha: 1).cgColor,
                                UIColor(red: 0.292, green: 0.099, blue: 0.992, alpha: 1).cgColor]
        gradientLayer.cornerRadius = 3
        gradientLayer.frame = dotIndicator.bounds
        dotIndicator.layer.addSublayer(gradientLayer)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let padding: CGFloat = 12
        self.backgroundColor = .primaryOnSurface
        let frame = CGRect(x: padding, y: 0, width: rect.width - (padding*2), height: 82)
        let bezierPath = UIBezierPath(roundedRect: frame, cornerRadius: 20)
        UIColor.primaryDark.setFill()
        bezierPath.fill()
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
    override var selectedItem: UITabBarItem? {
        didSet {
            moveDotIndicator()
        }
    }
    private func moveDotIndicator() {
        guard let items = items, let selectedItem = selectedItem else { return }
        let index = CGFloat(items.firstIndex(of: selectedItem) ?? 0)
        let itemWidth = frame.width / CGFloat(items.count)
        let xPosition = itemWidth * index + (itemWidth / 2) - (dotIndicator.frame.width / 2)
        let bottomPadding: CGFloat = deviceHasNotch ? 0 : 5
        UIView.animate(withDuration: 0.3) {
            self.dotIndicator.frame.origin.x = xPosition
            self.dotIndicator.frame.origin.y = (self.bounds.height/2) + bottomPadding
        }
    }
    override var safeAreaInsets: UIEdgeInsets {
        let insets = super.safeAreaInsets
        let bottomPadding: CGFloat = deviceHasNotch ? .zero : 24
        return UIEdgeInsets(top: 0, left: 0, bottom: insets.bottom + bottomPadding, right: 0)
    }
}
