//
//  DashboardViewController.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var lastRefreshLabel: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: DashboardViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dashboard"
        viewModel = DashboardViewModel(vc: self)
        viewModel.getUserRepositories()
    }
    
    @IBAction func didTapRefresh(_ sender: Any) {
        viewModel.getUserRepositories()
    }
    @IBAction func didTapLogOut(_ sender: Any) {
        viewModel.invalidateAndResetTimer()
        self.dismiss(animated: true)
    }
}


//MARK: Table view delegate
extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        let repository = viewModel.repository(at: indexPath.row)
        cell.repoNameLabel.text = repository.repository.name
        cell.latestPushLabel.text = "Latest push: \((repository.repository.updated_at)!)"
        cell.languageImage.image = repository.repositoryLanguageIcon
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "branchSegue", sender: self)
    }
}

extension DashboardViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "branchSegue",
           let destinationVC = segue.destination as? BranchViewController,
           let selectedRow = tableView.indexPathForSelectedRow?.row {
            destinationVC.repositoryName = viewModel.repository(at:selectedRow).repository.name ?? ""
        }
    }
}
