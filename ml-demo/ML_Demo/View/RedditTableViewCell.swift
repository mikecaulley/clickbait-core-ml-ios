//
//  RedditTableViewCell.swift
//  ML_Demo
//
//  Created by Michael Caulley on 6/9/17.
//  Copyright © 2017 Michael Caulley. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
	@IBOutlet weak var clickbaitEmoji: UILabel!
	
    static let cellIdentifier = "PostCell" // table cell identifier
    
    enum CellType {
        case clickbait
        case possible_clickbait
        case not_clickbait
    }
    
    func bind(redditPost post: RedditPost) {
        titleLabel?.text = post.title
        pointsLabel?.text = "\(post.score) points"
		if UserPreferences.turnOnClickBaitEmojis {
			if post.clickBaityness >= 0.5 {
				clickbaitEmoji.text = "💩"
			} else if post.clickBaityness < 0.5 && post.clickBaityness > 0.05 {
				clickbaitEmoji.text = "😬"
			} else {
				clickbaitEmoji.text = "🙌"
			}
		} else {
			clickbaitEmoji.text = ""
		}
    }
}
