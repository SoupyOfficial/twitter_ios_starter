//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Soupy Campbell on 9/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var userPhotoView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mediaImg: UIImageView!
    
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.rewtweet(tweetID: tweetID, success: {
            self.setRetweet(true)
        }, failure: {(error) in
            print("Failed to retweet \(error)")
        })
        
    }
    
    @IBAction func liked(_ sender: Any) {
        let toBeLiked = !likeTweet
        
        if(toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetID: tweetID, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("Like did not save \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetID, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("Unlike did not save \(error)")
            })
        }
    }
    
    
    var likeTweet:Bool = false
    var tweetID:Int = -1
    
    func setLike(_ isLiked:Bool) {
        
        likeTweet = isLiked
        if(likeTweet) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)

        }
        
    }
    
    func setRetweet(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
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
