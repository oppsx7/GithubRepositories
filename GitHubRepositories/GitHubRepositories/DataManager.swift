//
//  DataManager.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation

class DataManager {
    
    static var shared: DataManager = {
        let instance = DataManager()
        return instance
    } ()
    
    private var username: String
    
    private init() {
        username = ""
    }
    
    func getUsername() -> String {
        return username
    }
    
    func setUsername(username: String) {
        self.username = username
    }
}
