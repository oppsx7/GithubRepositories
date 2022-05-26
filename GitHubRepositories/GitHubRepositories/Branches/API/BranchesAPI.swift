//
//  BranchesAPI.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation

struct BranchesAPI {
    
    static func getBranches(for repository: String, completion: @escaping ([Branch]?) -> ()) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/repos/\(DataManager.shared.getUsername().trimmingCharacters(in: .whitespaces))/\(repository)/branches")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let branches = try JSONDecoder().decode([Branch].self, from: data!)
                completion(branches)
                print(branches)
                
            } catch {
                print(error)
            }
        })
        
        dataTask.resume()
    }
}
