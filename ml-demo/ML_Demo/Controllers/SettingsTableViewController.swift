//
//  SettingsTableViewController.swift
//  ML_Demo
//
//  Created by Jill Burgess on 7/5/17.
//  Copyright © 2017 Mike Caulley. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
	
    @IBOutlet weak var subredditTextField: UITextField! {
        didSet {
            subredditTextField.text = UserPreferences.subredditName
            subredditTextField.delegate = self
        }
    }
    @IBOutlet weak var clickbaitEmojiSwitch: UISwitch!
	@IBOutlet weak var hideClickbaitSwitch: UISwitch!
    
    @IBAction func subredditUpdated(_ sender: UITextField) {
        UserPreferences.subredditName = sender.text ?? "news"
        if UserPreferences.subredditName.contains(" ") { UserPreferences.subredditName = "news" }
        (tabBarController?.viewControllers?.first as! MainTableViewController).fetchData()
    }
    
    @IBAction func toggleClickbaitEmojis(_ sender: Any) {
        UserPreferences.turnOnClickBaitEmojis = !UserPreferences.turnOnClickBaitEmojis
    }
    @IBAction func toggleHideClickbait(_ sender: Any) {
        UserPreferences.hideClickbait = !UserPreferences.hideClickbait
        (tabBarController?.viewControllers?.first as! MainTableViewController).tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
	// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
