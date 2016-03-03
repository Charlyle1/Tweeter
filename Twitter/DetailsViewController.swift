//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/28/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!

    @IBOutlet weak var nameLabel: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    @IBOutlet weak var replyButton: UIButton!
    var tweet: Tweet!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImage.setImageWithURL(tweet.profileImageURL!)
        nameLabel.setTitle(tweet.name, forState: .Normal)
        usernameLabel.text = "@\(tweet.userName!)"
        textLabel.text = tweet.text
        favoritesLabel.text = "\(tweet.favoritesCount) Favorites"
        retweetLabel.text = "\(tweet.retweetCount) Retweets"
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        textLabel.sizeToFit()
        usernameLabel.sizeToFit()
        textLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        textLabel.preferredMaxLayoutWidth = 244
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        if tweet.favorited {
            likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
            likeButton.setImage(UIImage(named: "like-action.png"), forState: .Highlighted)
        }
        else {
            likeButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
            likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Highlighted)
        }


        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Normal)
            retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Highlighted)
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
            retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Highlighted)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onReplyButton(sender: AnyObject) {
        let image = UIImage(named: "reply-action-pressed_0.png")
        
        replyButton.setImage(image, forState: .Normal)
        
        
        
    }

    @IBAction func onLikeButton(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet, success: { (favorited: Bool) -> () in
            if favorited {
                self.likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Highlighted)
                self.likeButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
                self.favoritesLabel.text = "\(self.tweet.favoritesCount - 1) Favorites"
            }
            else {
                self.likeButton.setImage(UIImage(named: "like-action.png"), forState: .Highlighted)
                self.likeButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
                self.favoritesLabel.text = "\(self.tweet.favoritesCount + 1) Favorites"
            }
            
            }) { (error: NSError) -> () in
        }
        
    }
 
    @IBAction func onRetweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet, success: { (retweeted: Bool) -> () in
            
            if retweeted {
                
                self.retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Normal)
                self.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Highlighted)
                self.retweetLabel.text = "\(self.tweet.retweetCount - 1) Retweets"
            }
            else {
                self.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
                self.retweetButton.setImage(UIImage(named: "retweet-action-pressed.png"), forState: .Highlighted)
                self.retweetLabel.text = "\(self.tweet.retweetCount + 1) Retweets"
            }
            

            }) { (error: NSError) -> () in
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let profileViewController = segue.destinationViewController as? ProfileViewController {
            profileViewController.tweet = tweet
        }
        
        if let writingViewController = segue.destinationViewController as? WritingViewController {
            let button = sender as! UIBarButtonItem
            writingViewController.tweet = tweet
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
