//
//  FavoriteViewController.swift
//  Galaxia
//
//  Created by Mushfiq Humayoon on 28/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    private var animatableViews = [UIView]()
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        animatableViews = [tableView]
        toggleSubViews(show: false, animatableViews: animatableViews)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleSubViews(show: true, animatableViews: animatableViews)
    }
    // MARK: - Setup TableView
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let planetNib = UINib(nibName: PlanetTableViewCell.Identifier(), bundle: .main)
        tableView.register(planetNib, forCellReuseIdentifier: PlanetTableViewCell.Identifier())
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        toggleSubViews(show: false, animatableViews: animatableViews, direction: .left)
    }
}
extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.Identifier(), for: indexPath) as? PlanetTableViewCell else { return PlanetTableViewCell() }
        cell.selectionStyle = .none
        cell.colorTheme = .dark
        return cell
    }
}
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selection goes here
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
