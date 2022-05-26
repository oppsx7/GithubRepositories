//
//  AuthService.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation

struct AuthService {
    static func validateUser(_ username: String, completion: @escaping (String?) -> ()) {

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(username.trimmingCharacters(in: .whitespaces))")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data!)
                completion(authResponse.login)
                print(authResponse)
                
            } catch {
                print(error)
            }
        })

        dataTask.resume()
    }
}
