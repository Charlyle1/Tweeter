//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/29/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var tweets: [Tweet]!
    var tweet: Tweet!
    var user: User!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        user = tweet.user
        // Do any additional setup after loading the view.

        usernameLabel.text = "@\(user!.screenname!)"

        
        profileImage.setImageWithURL(user!.profileUrl!)
        backgroundImage.setImageWithURL(user!.profileBackgroundUrl!)
        nameLabel.text = user!.name
        usernameLabel.text = "@\(user!.screenname!)"
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        usernameLabel.sizeToFit()
        nameLabel.sizeToFit()
        profileImage.layer.cornerRadius = 3
        
        followersLabel.text = "\(user.followersCount)\n Followers"
        followingLabel.text = "\(user.followingCount)\n Following"
        tweetsLabel.text = "\(user.tweetsCount)\n Tweets"
        
        profileImage.clipsToBounds = true
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        TwitterClient.sharedInstance.getTimeline(tweet, success:{ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text)
            }
            self.tableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            print(tweets.count)
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetsProfileCell", forIndexPath: indexPath) as! TweetsProfileCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let writingViewController = segue.destinationViewController as? WritingViewController {
            let button = sender as! UIBarButtonItem
            writingViewController.tweet = tweet
        }
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
