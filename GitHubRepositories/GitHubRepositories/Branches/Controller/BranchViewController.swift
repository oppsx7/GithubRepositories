//
//  BranchViewController.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import UIKit

class BranchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: BranchesViewModel!
    var repositoryName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repositoryName
        viewModel = BranchesViewModel(vc: self)
        viewModel.getBranches(for: repositoryName)
    }

}

//MARK: Table view delegate
extension BranchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.branchesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchTableViewCell", for: indexPath) as! BranchTableViewCell
        cell.titleLabel.text = viewModel.branchName(at: indexPath.row)
        return cell
    }
}
