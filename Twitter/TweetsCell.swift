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
        TwitterClient.sharedInstance.retweet(tweet, success: { (retweeted: Bool) -> () in
            
            if retweeted {
                self.retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Normal)
                self.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Highlighted)
            }
            else {
                self.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
                self.retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Highlighted)
            }
            
            }) { (error: NSError) -> () in
        }

    }
    
    @IBAction func onClickLike(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet, success: { (favorited: Bool) -> () in
            if favorited {
                self.likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Highlighted)
                self.likeButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
                
            }
            else {
                self.likeButton.setImage(UIImage(named: "like-action.png"), forState: .Highlighted)
                self.likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
            }
            
            }) { (error: NSError) -> () in
        }

    }
    
    
}
