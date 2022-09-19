//
//  LoginViewController.swift
//  Twitter
//
//  Created by Soupy Campbell on 9/18/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func loginButton(_ sender: Any) {
        
        let myUrl = "https://api.twitter.com/oauth/request_token";
        
        TwitterAPICaller.client?.login(url: myUrl, success: {
            
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
            
        }, failure: {(Error) in
            print("Login Failed")
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
