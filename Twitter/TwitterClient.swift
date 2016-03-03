//
//  TwitterClient.swift
//  Twitter
//
//  Created by Carly Burroughs on 2/21/16.
//  Copyright © 2016 Carly Burroughs. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "myHEMVvlCwtwb2zBIFHQ7FAZ8", consumerSecret: "5fJgodlhGnZlqKaCVoNC8chjsxfhkwFwV1BZhiQ4Uv2SB2bnwN")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?

    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func update(status: String, replyTo: String, success: (Bool) -> (), failure: (NSError) -> ()) {
        POST("1.1/statuses/update.json?status=\(status.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            success(true)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in

        }
    }
    
    func retweet(tweet: Tweet, success: (Bool) -> (), failure: (NSError) -> ()) {
        if tweet.retweeted {
            POST("1.1/statuses/unretweet/\(tweet.id!).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
                tweet.retweeted = false
                tweet.retweetCount--
                
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
        } else {
            POST("1.1/statuses/retweet/\(tweet.id!).json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                tweet.retweeted = true
                tweet.retweetCount++
                
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
        }
        success(tweet.retweeted)
    }
    
    func favorite(tweet: Tweet, success: (Bool) -> (), failure: (NSError) -> ()) {
        if tweet.favorited {
            POST("1.1/favorites/destroy.json?id=\(tweet.id!)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                tweet.favoritesCount--
                tweet.favorited = false
                print("unliked!")
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
        } else {
            POST("1.1/favorites/create.json?id=\(tweet.id!)", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                tweet.favoritesCount++
                tweet.favorited = true
                print("liked!")
                
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
        }
        success(tweet.favorited)
    }
    
    func userTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
       GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func getTimeline(tweet: Tweet, success: ([Tweet]) -> (), failure: (NSError) -> ()) {

        GET("1.1/statuses/user_timeline.json?screen_name=\(tweet.screenName)&count=2", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            //print("user: \(user)")
            
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }
    
    
}
