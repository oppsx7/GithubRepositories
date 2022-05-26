//
//  BranchesViewModel.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit

class BranchesViewModel {
    private var branches = [Branch]()
    private var vc: BranchViewController!
    
    init(vc: BranchViewController) {
        self.vc = vc
    }
    
    func branchesCount() -> Int { branches.count }
    func branchName(at index: Int) -> String { branches[index].name }
    
    func getBranches(for repository: String) {
        BranchesAPI.getBranches(for: repository) { branches in
            guard let branches = branches else {
                let ac = UIAlertController(title: "Error", message: "No branches found for that repository.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                    self.vc.dismiss(animated: true)
                }))
                self.vc.present(ac, animated: true)
                return
            }
            
            self.branches = branches
            DispatchQueue.main.async {
                self.vc.tableView.reloadData()
            }
            
        }
    }
}
