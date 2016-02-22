//
//  TweetsCell.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/22/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit




class TweetsCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            /**if let profileImageURL = tweet.profileImageURL {
                let imageRequest = NSURLRequest(URL: profileImageURL)
                profileImageView.setImageWithURLRequest(
                    imageRequest,
                    placeholderImage: nil,
                    success: { (imageRequest, imageResponse, image) -> Void in
                        
                        // imageResponse will be nil if the image is cached
                        if imageResponse != nil {
                            print("Image was NOT cached, fade in image")
                            self.profileImageView.alpha = 0.0
                            self.profileImageView.image = image
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.profileImageView.alpha = 1.0
                            })
                        } else {
                            self.profileImageView.image = image
                        }
                    },
                    failure: { (imageRequest, imageResponse, error) -> Void in
                        self.profileImageView.image = nil
                })**/
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
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
