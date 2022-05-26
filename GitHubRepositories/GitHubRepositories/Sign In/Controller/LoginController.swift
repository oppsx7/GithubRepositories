//
//  ViewController.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import UIKit
import SkeletonView

class LoginController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var signInViewModel: SignInViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInViewModel = SignInViewModel(vc: self)
        
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        signInViewModel.validateUser(username: textField.text ?? "unknown")
    }
    
}

//MARK: Prepare for segue
extension LoginController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDashboardSegue" {
            
        }
    }
}

