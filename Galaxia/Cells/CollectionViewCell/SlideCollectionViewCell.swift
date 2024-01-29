//
//  SlideCollectionViewCell.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var shadowImage: UIImageView!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setCornerRadius(22)
    }

}
