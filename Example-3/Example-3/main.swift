//
//  main.swift
//  Example-3
//
//  Created by Sergey Ryazanov on 06.03.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation
import Alamofire

class RepoName: Codable {
    let name: String
}

var semaphore = DispatchSemaphore(value: 0 )

func getRepositoryList(for name: String, result: @escaping (([String]?) -> Void)) {
    let urlString = "https://api.github.com/users/\(name)/repos"
    guard let url = URL(string: urlString) else {
        result(nil)
        return
    }

//    Alamofire.request(url).responseJSON { (response) in
//        debugPrint(response)
//        semaphore.signal()
//    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data {
            let list = try? JSONDecoder().decode([RepoName].self, from: data)
            result(list?.map { $0.name } )
        }
      semaphore.signal()
    }

    task.resume()

    semaphore.wait()
}

print("Enter github nickname:")
if let nickname = readLine() {
    getRepositoryList(for: nickname) { (list) in
        guard let list = list else {
            print("Can't get repos for user: \(nickname)")
            return
        }

        print("List of repositories:")
        for repo in list {
            print(repo)
        }
    }
}
