//
//  DetailViewController.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var navigationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedView: SSSegmentedControl!
    // MARK: - Properties
    var previewYOffset: CGFloat = 0
    // MARK: - ViewModel
    private let viewModel = DetailViewModel()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeachField()
        setupTableView()
        setupActivityIndicator()
        initBindings()
    }
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    private func initBindings(isInit: Bool = true) {
        var initCall = isInit
        viewModel.$planetList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                if !initCall {
                    self.activityIndicator.stopAnimating()
                }
                initCall = false
                self.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    // MARK: - Setup Search Field
    private func setupSeachField() {
        searchTextField.delegate = self
        searchTextField.setIcons(leftIcon: .arrowBack, rightIcon: .filterIcon, color: .labelDarkVarient)
        searchTextField.onLeftIconTap = { self.dismiss(animated: true) }
        searchTextField.onRightIconTap = didFilterTapped
        searchTextField.setPlaceholder(text: "Search your destination", color: .onSurfaceLight)
    }
    private func didFilterTapped() {
        print("did filter tapped")
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let planetNib = UINib(nibName: PlanetTableViewCell.Identifier(), bundle: .main)
        tableView.register(planetNib, forCellReuseIdentifier: PlanetTableViewCell.Identifier())
    }
    @IBAction func backButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.planetList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.Identifier(), for: indexPath) as? PlanetTableViewCell else { return PlanetTableViewCell() }
        cell.selectionStyle = .none
        cell.colorTheme = .light
        cell.setFetchedData(viewModel.planetList[indexPath.row])
        return cell
    }
}
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selection goes here
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.3, animations: {
            self.searchTextField.alpha = yOffset > self.previewYOffset ? 0 : 1
            self.titleLabel.alpha = yOffset > self.previewYOffset ? 1 : 0
            self.searchFieldHeightConstraint.constant = yOffset > self.previewYOffset ? -48 : 14
            self.navigationViewHeightConstraint.constant = yOffset > self.previewYOffset ? 148 : 164
            self.segmentedView.backgroundColor = yOffset > self.previewYOffset ? .segmentBackround : .clear
            self.view.layoutIfNeeded()
        })
        previewYOffset = yOffset
    }
}
extension DetailViewController: UITextFieldDelegate {
    // searchfield delegate goes here
}
