//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/29/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    var tweet: Tweet!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = User._currentUser

        usernameLabel.text = "@\(tweet.userName!)"

        
        profileImage.setImageWithURL(tweet.profileImageURL!)
        backgroundImage.setImageWithURL(user.profileBackgroundUrl!)
        nameLabel.text = tweet.name
        usernameLabel.text = "@\(tweet.userName!)"
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        usernameLabel.sizeToFit()
        nameLabel.sizeToFit()
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
