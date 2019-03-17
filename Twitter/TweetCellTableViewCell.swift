 //
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by ellehcim on 3/8/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var likedBttn:Bool = false;
    var tweetId: Int = -1;
    var retweetBttn:Bool = false;

    
    func setFavorite (_ isFavorited:Bool){
        likedBttn = isFavorited;
        if(likedBttn) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: .normal);

        }
        else
        {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal);
        }
    }
    @IBAction func likedButton(_ sender: Any) {
        let toBeFavorited = !likedBttn;
        if (toBeFavorited)
        {
            TwitterAPICaller.client?.favoriteTweet( tweetId: tweetId,
                                                    success: {
                                                        self.setFavorite(true)
                                                        print("is favorited")
                                                    },
                                                    failure: { (Error) in print("Favorite didn't succeed \(Error)")} )
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId,
                                                     success: {
                                                        self.setFavorite(false)
                                                        print("is unfavorited")
                                                    },
                                                     failure: { (Error) in print("UNfavorite didn't succeed \(Error)")} )
        }
    }
    
    
    func setRetweeted(_ isRetweeted: Bool){
        retweetBttn = isRetweeted;
        if(retweetBttn){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal);
//            retweetButton.isEnabled = false;
            //no need for user interaction.
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal);
//            retweetButton.isEnabled = true;
        }
    }
    @IBAction func retweetedButton(_ sender: Any) {
        let toBeRetweeted = !retweetBttn;
        if (toBeRetweeted){
            TwitterAPICaller.client?.retweetTweet(tweetId: tweetId,
                                              success: {
                                                self.setRetweeted(true)
                                                print("is Retweeted")
                                            },
                                              failure: { (Error) in print("Retweeting didn't succeed \(Error)")} )
        
        } else {
            TwitterAPICaller.client?.retweetTweet(tweetId: tweetId,
                                                     success: {
                                                        self.setRetweeted(false)
                                                        print("is unretweeted")
            },
                                                     failure: { (Error) in print("UNRetweeting didn't succeed \(Error)")} )
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
