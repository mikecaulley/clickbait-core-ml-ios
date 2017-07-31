//
//  MainTableViewController.swift
//  ML_Demo
//
//  Created by Mike Caulley on 6/9/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

import UIKit
import Vision

class MainTableViewController : UITableViewController, UITabBarControllerDelegate {
    
    
    let showBrowserIdentifier = "ShowBrowser" // segue to browser view identifier
    
    let network: NetworkProtocol = NetworkSource()
    
    var posts: [RedditPost] = [] // data to fill table with
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        tableView.register(UINib.init(nibName: "RedditTableViewCell", bundle: nil), forCellReuseIdentifier: RedditTableViewCell.cellIdentifier)
        self.tableView.estimatedRowHeight = 65.0; // Estimate the height you want
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        fetchData()
    }
    
    func fetchData() {
        self.posts.removeAll()
        network.fetchPosts() { newPosts in
            self.posts.append(contentsOf: newPosts)
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Tab Bar delegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is MainTableViewController {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserPreferences.hideClickbait {
            return posts.filter { $0.clickBaityness < 0.5}.count
        }
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reuse cell
        let cell = tableView.dequeueReusableCell(withIdentifier: RedditTableViewCell.cellIdentifier, for:indexPath) as! RedditTableViewCell
        
        var filteredPosts: [RedditPost]?
        if UserPreferences.hideClickbait {
            filteredPosts = posts.filter { $0.clickBaityness < 0.5}
        } else {
            filteredPosts = posts
        }
        cell.bind(redditPost: filteredPosts![indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showBrowserIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // set properties in browser view controller before segue
        if segue.identifier == showBrowserIdentifier {
            let browserViewController = segue.destination as! BrowserViewController
            let post = posts[tableView.indexPathForSelectedRow!.row]
            browserViewController.postTitle = post.title
            browserViewController.postUrl = post.url
        }
    }
    
}
