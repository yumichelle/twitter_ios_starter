//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by ellehcim on 3/8/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]();
    //storing data in empty local container, var (something that can change)
    var numOfTweet: Int!;
    
    let pullToRefreshControl = UIRefreshControl();
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadTweets(); //done once
        
        pullToRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged);
        tableView.refreshControl = pullToRefreshControl;
        
        //automatic row height
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets(); //automatically appears
    }
    
    @objc func loadTweets(){
        
        numOfTweet = 20;
        let homeTimeline = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: homeTimeline, parameters: myParams, success: { (tweets:[NSDictionary]) in
            // result is called tweets
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                //for every tweet in tweets, add in tweetArray
                self.tweetArray.append(tweet)
                
                self.tableView.reloadData();
                
                self.pullToRefreshControl.endRefreshing();
                
            }
        }, failure: { (Error) in
            print("couldn't retrieve tweets")
        })
    }
    
    
    func loadMoreTweets() {
        let homeTimeline = "https://api.twitter.com/1.1/statuses/home_timeline.json";
        numOfTweet = numOfTweet+20;
        let myParams = ["count":numOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: homeTimeline, parameters: myParams, success: { (tweets:[NSDictionary]) in
            // result is called tweets
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                //for every tweet in tweets, add in tweetArray
                self.tweetArray.append(tweet)
                
                self.tableView.reloadData();
                
            }
        }, failure: { (Error) in
            print("couldn't retrieve tweets")
        })
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count{
            //getting to end of the page 
            loadMoreTweets()
        }
    }
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        print("logging out");
        TwitterAPICaller.client?.logout();
        self.dismiss(animated: true, completion: nil);
        //screen dismisses itself. nil for not things happening when it's gone.
        UserDefaults.standard.set(false, forKey: "userLoggedIn");
        //userLoggedIn: true for logged in, false when logged out.
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count;
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell;
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary;
        
        cell.usernameLabel.text = user["name"] as? String;
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String;
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!);
        let data = try? Data(contentsOf: imageURL!);
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData);
        }
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool);
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool);
        
        return cell;
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
