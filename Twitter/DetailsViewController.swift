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
        
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        textLabel.sizeToFit()
        usernameLabel.sizeToFit()
        textLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        textLabel.preferredMaxLayoutWidth = 244
        userImage.layer.cornerRadius = 3
        userImage.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onReplyButton(sender: AnyObject) {
        if let image = UIImage(named: "reply-action-pressed_0.png") {
            replyButton.setImage(image, forState: .Normal)
        }
    }

    @IBAction func onLikeButton(sender: AnyObject) {
        if let image = UIImage(named: "reply-action-pressed_0.png") {
            replyButton.setImage(image, forState: .Normal)
        }

    }
 
    @IBAction func onRetweetButton(sender: AnyObject) {
        if let image = UIImage(named: "retweet-action-pressed.png") {
            retweetButton.setImage(image, forState: .Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let profileViewController = segue.destinationViewController as! ProfileViewController
        profileViewController.tweet = tweet
        
        
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
