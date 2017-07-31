//
//  BrowserViewController.swift
//  ML_Demo
//
//  Created by Mike Caulley on 6/9/17.
//  Copyright (c) 2014 Mike Caulley. All rights reserved.
//

import Foundation
import UIKit

class BrowserViewController : UIViewController {
    
    var postTitle: String?
    var postUrl: String?
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = postTitle
        
        let url = URL(string: postUrl!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}
