//
//  SignInViewModel.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit
import SkeletonView

struct SignInViewModel {
    let vc: LoginController!
    
    init(vc: LoginController) {
        self.vc = vc
    }
    func validateUser(username: String) {
        vc.view.showGradientSkeleton()
        AuthService.validateUser(username) { username in
            DispatchQueue.main.async {
                vc.view.hideSkeleton()
                vc.textField.text = ""
                
                if let username = username {
                    DataManager.shared.setUsername(username: username)
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController")
                    let navigationController = UINavigationController(rootViewController: dashboardVC)
                    navigationController.navigationBar.prefersLargeTitles = true
                    navigationController.modalPresentationStyle = .fullScreen
                    vc.present(navigationController, animated: true)
                } else {
                    let ac = UIAlertController(title: "Error", message: "Username not found", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    vc.present(ac, animated: true)
                }
            }
           
            
            
        }
    }
}
