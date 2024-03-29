//
//  ViewController.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var galaxyStackView: UIStackView!
    
    private var animatableViews = [UIView]()
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeachField()
        setupCollectionView()
        setupGalaxyStackView()
        animatableViews = [searchTextField, collectionView, headerContainer, galaxyStackView]
        toggleSubViews(show: false, animatableViews: animatableViews, direction: .right)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleSubViews(show: true, animatableViews: animatableViews, direction: .right)
    }
    // MARK: - Setup Search Field
    private func setupSeachField() {
        searchTextField.setIcons(leftIcon: .searchIcon, rightIcon: .arrowRight)
        searchTextField.onLeftIconTap = { self.searchTextField.becomeFirstResponder() }
        searchTextField.onRightIconTap = didSearchTapped
        searchTextField.setPlaceholder(text: "Search your destination", color: .onSurfaceLight)
    }
    private func didSearchTapped() {
        self.searchTextField.endEditing(true)
        let storyBoard = UIStoryboard(name: "Detail", bundle: .main)
        let viewController = storyBoard.instantiateViewController(identifier: "DetailViewController")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let slideNib = UINib(nibName: SlideCollectionViewCell.Identifier(), bundle: .main)
        collectionView.register(slideNib, forCellWithReuseIdentifier: SlideCollectionViewCell.Identifier())
        let layout = StackCollectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        pageControl.currentPageIndicatorTintColor = .pageSelectedTint
        pageControl.pageIndicatorTintColor = .pageTint
    }
    // MARK: - Setup Galaxy Stack
    private func setupGalaxyStackView() {
        galaxyStackView.subviews.forEach { subView in
            let backgroundViews = subView.subviews.filter { view in
                 return !(view is UILabel)
            }
            backgroundViews.forEach { $0.layer.cornerRadius = 16 }
        }
    }
    // MARK: - updatePageControl
    fileprivate func updatePageControl() {
        let pageIndex = round(collectionView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    // MARK: - UpdateCellOpacity onSlide
    fileprivate func updateCellOpacity() {
        let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), .zero)
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        if let cells = collectionView.visibleCells as? [SlideCollectionViewCell],
           (cells.count - 1) >= minVisibleIndex {
            if minVisibleIndex == .zero {
                cells[.zero].contentView.alpha = abs(percentageDeltaOffset)
            } else {
                cells[minVisibleIndex].contentView.alpha = percentageDeltaOffset
            }
        }
    }
    // MARK: - ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        toggleSubViews(show: false, animatableViews: animatableViews, direction: .right)
    }
}
// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SlideCollectionViewCell.Identifier(), for: indexPath) as? SlideCollectionViewCell
        else { return SlideCollectionViewCell() }
        if indexPath.row > 0 { cell.contentView.alpha = 0 }
        return cell
    }
}
// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // layout size goes here
}
// MARK: - CollectionView PageControl Setup
extension HomeViewController: UIScrollViewDelegate {
    // MARK: - ScrollViewDidScroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePageControl()
        updateCellOpacity()
    }
}
// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // selection goes here
    }
}
