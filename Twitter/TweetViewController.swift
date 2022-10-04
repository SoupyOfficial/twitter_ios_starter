//
//  TweetViewController.swift
//  Twitter
//
//  Created by Soupy Campbell on 9/29/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var countTextView: UITextView!
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        
        //print("TEST")
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //self.countTextview.delegate = self
        // Set the max character limit
        let characterLimit = 280
        
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        // TODO: Update Character Count Label
        countTextView.text = "\( 280-newText.count) left out of 280"

        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func tweetButton(_ sender: Any) {
        
        if(!tweetView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetView.text, success: {
                self.dismiss(animated: true)
            }, failure: {(error) in
                print("Error Posting Tweet /(error)")
                self.dismiss(animated: true)
            })
        }
        else {
            self.dismiss(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetView.becomeFirstResponder()
        // Do any additional setup after loading the view.
        tweetView.delegate = self
        countTextView.text = "140 left out of 140"
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
