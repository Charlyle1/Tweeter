//
//  TweetsCell.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/22/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit




class TweetsCell: UITableViewCell {


    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        didSet {
                
                if let thumbURL = tweet.profileImageURL {
                profileImageView.setImageWithURL(thumbURL)
            }
            
            nameLabel.text = tweet.name
            usernameLabel.text = "@\(tweet.userName!)"
            tweetTextLabel.text = tweet.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        tweetTextLabel.sizeToFit()
        usernameLabel.sizeToFit()
        tweetTextLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        tweetTextLabel.preferredMaxLayoutWidth = 244
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state

    }
    

    @IBAction func onClickReply(sender: AnyObject) {
        if let image = UIImage(named: "reply-action-pressed_0.png") {
            replyButton.setImage(image, forState: .Normal)
        }
    }
    
    @IBAction func onClickRetweet(sender: AnyObject) {
        if let image = UIImage(named: "retweet-action-pressed.png") {
            retweetButton.setImage(image, forState: .Normal)
        }
    }
    
    @IBAction func onClickLike(sender: AnyObject) {
        if let image = UIImage(named: "like-action-pressed.png") {
            likeButton.setImage(image, forState: .Normal)
        }
    }
    
    
}
