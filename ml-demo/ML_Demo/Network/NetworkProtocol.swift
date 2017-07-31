//
//  NetworkProtocol.swift
//  ML_Demo
//
//  Created by Michael Caulley on 6/9/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

protocol NetworkProtocol {
    func fetchPosts(completionHandler: @escaping (([RedditPost]) -> Void))
}
