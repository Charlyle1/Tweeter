//
//  WritingViewController.swift
//  Twitter
//
//  Created by Carly Burroughs on 3/3/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit

class WritingViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    var tweet: Tweet!
    var tweets: [Tweet]!
    
    var replyeeName: String?
    var userID: String?

    @IBOutlet weak var tweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.setImageWithURL((User._currentUser?.profileUrl)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickTweet(sender: AnyObject) {
        if let tweetText = tweetTextField.text as String? {
            if replyeeName != nil && userID != nil {
                TwitterClient.sharedInstance.update(tweetText, replyTo: userID!, success: { (result: Bool) -> () in
                    }, failure: { (error: NSError) -> () in
                })
            }
            else {
                TwitterClient.sharedInstance.update(tweetText, replyTo: "", success: { (result: Bool) -> () in
                    }, failure: { (error: NSError) -> () in
                })
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let tweetsViewController = segue.destinationViewController as? TweetsViewController {
            let button = sender as! UIButton
            onClickTweet(button)
            tweetsViewController.tweets = tweets
        }

    }


}
