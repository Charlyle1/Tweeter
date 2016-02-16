//
//  TwitterClient.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/16/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "myHEMVvlCwtwb2zBIFHQ7FAZ8"
let twitterConsumerSecret = "5fJgodlhGnZlqKaCVoNC8chjsxfhkwFwV1BZhiQ4Uv2SB2bnwN"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            }
        return Static.instance
    }
}
    

    
    
