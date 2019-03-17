//
//  LoginViewController.swift
//  Twitter
//
//  Created by ellehcim on 3/8/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        onLoginButton.layer.shadowColor = UIColor.black
//        onLoginButton.layer.shadowRadius = 50
//        onLoginButton.layer.shadowOpacity = 0.5
//        onLoginButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        view.setGradient(colorOne: UIColor(red: 29/255.0, green: 140/255.0, blue: 240/255.0, alpha: 1.0), colorTwo: UIColor(red: 150/255.0, green: 190/255.0, blue: 255/255.0, alpha: 1.0))
      }
    
    override func viewDidAppear(_ animated: Bool) {
        // checks userLoggedIn is there the 1st time.
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self);
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        print("tap");
        
        let requestToken = "https://api.twitter.com/oauth/request_token";
        TwitterAPICaller.client?.login(url: requestToken, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn");
            // note in memory: since account's verified, don't ask to log in a 2nd time.; variable userLoggedIn is true for every log in and will check this first.
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            //transition to home.
        }, failure: { (Error) in
            print("couldn't log in")
        });
    }
    
    
    
    
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
