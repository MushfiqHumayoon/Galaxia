//
//  ChipCollectionViewCell.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    // MARK: - Properties
    var colorTheme: ColorTheme = .dark {
        didSet {
            setupTheme()
        }
    }
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: - SetData
    func setData(with chipData: ChipData) {
        icon.image = chipData.image
        label.text = chipData.label
    }
    func setupTheme() {
        containerView.backgroundColor = colorTheme == .dark ? .darkBackground : .white
        containerView.layer.borderWidth = 1
        let color: UIColor = colorTheme == .dark ? .clear : .labelDarkVarient
        containerView.layer.borderColor = color.cgColor
        containerView.layer.cornerRadius = self.frame.height / 2
        label.textColor = colorTheme == .dark ? .onSurfaceLight : .labelDarkVarient
    }
}
