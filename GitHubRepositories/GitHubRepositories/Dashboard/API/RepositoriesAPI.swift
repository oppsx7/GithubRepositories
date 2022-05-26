//
//  WebService.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation

struct RepositoriesAPI {
    
    static func getUserRepositories(_ username: String, completion: @escaping ([Repository]?) -> ()) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(username.trimmingCharacters(in: .whitespaces))/repos")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data!)
                completion(repositories)
                print(repositories)
                
            } catch {
                print(error)
            }
        })
        
        dataTask.resume()
    }
}

