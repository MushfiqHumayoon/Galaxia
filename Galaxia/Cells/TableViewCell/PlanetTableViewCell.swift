//
//  PlanetTableViewCell.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var galaxyLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    var colorTheme: ColorTheme = .dark {
        didSet {
            setupParentViews()
            setupLabelView()
        }
    }
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBookButton()
        setupCollectionView()
    }
    // MARK: - Set Fetched Data
    func setFetchedData(_ result : ApiResult) {
        titleLabel.text = result.title
        detailLabel.text = result.description
    }
    // MARK: - Additional Methods
    private func setupLabelView() {
        titleLabel.textColor = colorTheme == .dark ? .white : .labelDarkVarient
        let labelColor: UIColor = colorTheme == .dark ? .onSurfaceLight : .labelDarkVarient
        galaxyLabel.textColor = labelColor
        detailLabel.textColor = labelColor
    }
    private func setupParentViews() {
        let backgroundColor: UIColor = colorTheme == .dark ? .primaryOnSurface : .white
        let forgroundColor: UIColor = colorTheme == .dark ? .darkBackground : .lightLine
        parentView.setCornerRadius(16)
        labelContainerView.setCornerRadius(6)
        labelContainerView.backgroundColor = backgroundColor
        buttonContainerView.setCornerRadius(6)
        buttonContainerView.backgroundColor = backgroundColor
        buttonContainerView.addDottedTopBorder(width: UIScreen.main.bounds.width, color: forgroundColor)
        lineView.backgroundColor = forgroundColor
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let columnLayout = CustomViewFlowLayout()
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        let slideNib = UINib(nibName: ChipCollectionViewCell.Identifier(), bundle: .main)
        collectionView.register(slideNib, forCellWithReuseIdentifier: ChipCollectionViewCell.Identifier())
    }
    private func setupBookButton() {
        bookButton.setCornerRadius(8)
    }
}

extension PlanetTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyChips.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChipCollectionViewCell.Identifier(), for: indexPath) as? ChipCollectionViewCell
        else { return ChipCollectionViewCell() }
        cell.setData(with: dummyChips[indexPath.item])
        cell.colorTheme = colorTheme
        return cell
    }
}
extension PlanetTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = dummyChips[indexPath.row].label
        let font = UIFont.fontSemiBold(ofSize: 14)
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = string.size(withAttributes: fontAttribute)
        let width = size.width
        return CGSize(width:width + 8, height: 25)
       }
}

extension String {
    func width(_ font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        let size = attributedString.size()
        return size.width
    }
}
class CustomViewFlowLayout: UICollectionViewFlowLayout {

let cellSpacing:CGFloat = 6

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            self.minimumLineSpacing = 6.0
            self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 6)
            let attributes = super.layoutAttributesForElements(in: rect)

            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + cellSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            }
            return attributes
    }
}
