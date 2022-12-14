//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Soupy Campbell on 9/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numTweets = Int()
    let myRefreshControl = UIRefreshControl()
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        
        UserDefaults.standard.set(false, forKey: "loggedIn")
        TwitterAPICaller.client?.logout();
        self.dismiss(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.nameLabel.text = user["name"] as? String
        cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        let imgURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imgURL!)
        
        if let imgData = data {
            cell.userPhotoView.image = UIImage(data: imgData)
        }
        
        let entities = tweetArray[indexPath.row]["entities"] as! NSDictionary
        
        let mediaPresent = entities["media"] != nil
        
//        if(mediaPresent) {
//            let media = entities["media"]["media_url_https"]
//            print(media)
//            //let mediaUrlPresent:Bool = media[media.index(of: "media_url_https")].
//
//           if(mediaUrlPresent) {
//                let mediaUrl = media[media.index(of: "media_url_https")] as! String
//                print(mediaUrl)
//            }
//        }
        
        cell.setLike(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        //print(tweetArray[indexPath.row]["retweeted"] as! Bool)
        cell.setRetweet(tweetArray[indexPath.row]["retweeted"] as! Bool)
//        if(entities["media"]) {
//            cell.mediaImg.image = entities["media"]["media_url_https"]
//        }
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    @objc func loadTweets() {
        
        numTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : numTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: {(tweets: [NSDictionary]) in
            //print(tweets)
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                //print(tweet)
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Load Failed")
            print(Error.localizedDescription)
        })
    }
    
    func loadMoreTweets() {
        
        numTweets = numTweets + 20
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : numTweets]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: {(tweets: [NSDictionary]) in
            //print(tweets)
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                //print(tweet)
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Load Failed")
            print(Error.localizedDescription)
        })
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
