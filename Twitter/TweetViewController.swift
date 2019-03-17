//
//  TweetViewController.swift
//  Twitter
//  Icons made by Designerz Base from www.flaticon.com.
//  Created by ellehcim on 3/16/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let myColor = UIColor.black
//        tweetTextView.layer.borderColor = myColor.cgColor
//        tweetTextView.layer.borderWidth = 1.0
        
        tweetTextView.layer.borderWidth = 0.0
        tweetTextView.layer.masksToBounds = false
        tweetTextView.layer.cornerRadius = 5.0;
        tweetTextView.layer.backgroundColor = UIColor.white.cgColor
        tweetTextView.layer.borderColor = UIColor.clear.cgColor
        tweetTextView.layer.shadowColor = UIColor.black.cgColor
        tweetTextView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tweetTextView.layer.shadowOpacity = 0.2
        tweetTextView.layer.shadowRadius = 4.0
        
        tweetTextView.becomeFirstResponder()
    }
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
        // we don't want anything to happen after so nil.
        print("canceling tweet");
    }
    
    @IBAction func tweet(_ sender: Any) {
        print("sent tweet")
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {self.dismiss(animated: true, completion: nil)}, failure: {(error) in         print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
                })
        }
        else{
            self.dismiss(animated: true, completion: nil);
            // if empty
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
