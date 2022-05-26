//
//  Repository.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit

enum LanguageEnum: String {
    case swift = "Swift"
    case objC = "Objective-C"
    case java = "Java"
    case PHP = "PHP"
    case C = "C"
    case CSS = "CSS"
    case CSharp = "C#"
    
}


struct Repository: Codable {
    let language: String?
    let name: String?
    let updated_at: String?
}

struct WrappedRepository {
    let repository: Repository
    let repositoryLanguageIcon: UIImage?
}
