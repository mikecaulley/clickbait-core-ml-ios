//
//  NetworkSource.swift
//  ML_Demo
//
//  Created by Michael Caulley on 6/9/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

import Foundation

class NetworkSource: NetworkProtocol {
    
    func fetchPosts(completionHandler: @escaping (([RedditPost]) -> Void)) {
        let endpoint = "https://reddit.com/r/" + UserPreferences.subredditName + "/top.json"
        let url = URL(string: endpoint)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            // Clear posts array
            var posts = [RedditPost]()
            
            // Unwrap json and add to posts array
            do {
                let json = try JSONSerialization.jsonObject(with: data!,
                                                            options: .mutableContainers) as! NSDictionary
                if let data = json["data"] as? NSDictionary,
                    let children = data["children"] as? Array<NSDictionary> {
                    for child in children {
                        if let title = (child["data"] as! NSDictionary)["title"] as? String,
                            let url = (child["data"] as! NSDictionary)["url"] as? String,
                            let score = (child["data"] as! NSDictionary)["score"] as? Int,
                            let clickBaityness = RedditPost.calculateClickBaitPercentageFor(title) {
                            let post = RedditPost(title: title,
                                                  url: url,
                                                  score: score,
                                                  clickBaityness: clickBaityness)
                            posts.append(post)
                        }
                    }
                }
                
                // Call completion block on the main thread
                DispatchQueue.main.async(execute: {
                    completionHandler(posts)
                })
            } catch {
                print("Error parsing json")
            }
        }).resume()
    }
}
