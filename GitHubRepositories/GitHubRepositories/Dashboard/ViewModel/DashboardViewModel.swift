//
//  DashboardViewModel.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit
import SkeletonView

class DashboardViewModel {
    private var repositories: [WrappedRepository] = [WrappedRepository]()
    private var vc: DashboardViewController!
    private var minutes:Double = 0
    private var timer: Timer?
    
    init(vc: DashboardViewController) {
        self.vc = vc
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true, block: { _ in
            self.minutes += 0.5
            self.updateLastRefreshLabel()
        })
    }
    
    func getUserRepositories() {
        vc.view.showGradientSkeleton()
        RepositoriesAPI.getUserRepositories(DataManager.shared.getUsername()) { repos in
            
            self.minutes = 0
            self.updateLastRefreshLabel()
            guard let repos = repos else {
                let ac = UIAlertController(title: "Error", message: "No repositories found for that user.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
                    self.vc.dismiss(animated: true)
                }))
                self.vc.present(ac, animated: true)
                return
            }

            self.constructRepositoriesArray(repos: repos)
            DispatchQueue.main.async {
                self.vc.view.hideSkeleton()
                self.vc.tableView.reloadData()
            }
            
        }
    }
    
    func getMinutesSinceLastRefresh() -> String {
        
        if minutes > 1 {
            return "\(minutes) minutes ago"
        } else if minutes == 1 {
            return "a minute ago"
        } else {
            return "a moment ago"
        }
        
    }
    
    func invalidateAndResetTimer() {
        timer?.invalidate()
        minutes = 0
    }
    func repositoriesCount() -> Int { repositories.count }
    func repository(at index: Int) -> WrappedRepository { repositories[index]}
    func updateLastRefreshLabel() {
        DispatchQueue.main.async {
            self.vc.lastRefreshLabel.text = "Last refreshed: \(self.getMinutesSinceLastRefresh())"
        }
    }
    func getProperRepositoryLanguageIcon(_ language: String?) -> UIImage? {
        switch language {
        case LanguageEnum.C.rawValue:
            return UIImage(named: "language_c")
        case LanguageEnum.CSS.rawValue:
            return UIImage(named: "language_css")
        case LanguageEnum.PHP.rawValue:
            return UIImage(named: "language_php")
        case LanguageEnum.java.rawValue:
            return UIImage(named: "language_java")
        case LanguageEnum.objC.rawValue:
            return UIImage(named: "language_objc")
        case LanguageEnum.swift.rawValue:
            return UIImage(named: "language_swift")
        case LanguageEnum.CSharp.rawValue:
            return UIImage(named: "language_c#")
        default:
            return UIImage(named: "language_unknown")
        }
    }
    
    func constructRepositoriesArray(repos: [Repository]) {
        repos.forEach { repo in
            repositories.append(WrappedRepository(repository: repo, repositoryLanguageIcon: getProperRepositoryLanguageIcon(repo.language)))
        }
    }
}
