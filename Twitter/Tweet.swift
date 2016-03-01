//
//  Tweet.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/21/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var name: String?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageURL: NSURL?
    var userName: String?
    var profileBackgroundUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        name = dictionary["user"]!["name"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
        if let tweeterProfileImageURLString = dictionary["user"]!["profile_image_url_https"] as? String {
            profileImageURL = NSURL(string: tweeterProfileImageURLString)
        }
        userName = dictionary["user"]!["screen_name"] as? String
        let profileBackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundUrlString = profileBackgroundUrlString {
            profileBackgroundUrl = NSURL(string: profileBackgroundUrlString)
        }


    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
    }
}
