//
//  ItemSize.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 29/01/24.
//

import UIKit

public enum ItemSize {
    case fixed(CGSize)
    case horizontalAspectFit(spacing: CGFloat, aspect: CGFloat)
    case verticalAspectFit(spacing: CGFloat, aspect: CGFloat)
}

public extension ItemSize {
    func size(in collectionView: UICollectionView) -> CGSize {
        let multiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4.0 : 2.0

        switch self {
        case .fixed(let size):
            return size
        case .horizontalAspectFit(let hspacing, let aspect):
            let spacing = hspacing * UIScreen.main.scale * multiplier
            let width = collectionView.bounds.width - spacing
            
            return CGSize(width: width, height: width / aspect)
        case .verticalAspectFit(let vspacing, let aspect):
            let spacing = vspacing * UIScreen.main.scale * multiplier
            let height = collectionView.bounds.height - spacing
            
            return CGSize(width: height * aspect, height: height)
        }
    }
}
