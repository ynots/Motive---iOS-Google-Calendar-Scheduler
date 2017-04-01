//
//  ViewController.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-03-28.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func signOutWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        refreshInterface()
    }
    
    @IBAction func refreshButtonWasPressed(_ sender: Any) {
        refreshInterface()
        if (GIDSignIn.sharedInstance().currentUser != nil) {
            performSegue(withIdentifier: "loginToDailyCalendar", sender: nil)
        }
    }
    func refreshInterface() {
        print("Refresh Interface: \(GIDSignIn.sharedInstance().currentUser?.profile.name!)")
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            self.signInButton.isHidden = true
            self.signOutButton.isHidden = false
            self.welcomeLabel.text = "Welcome, \(currentUser.profile.name!)"
            let profilePicURL = currentUser.profile.imageURL(withDimension: 175)
            self.profilePic.image = UIImage(data: NSData(contentsOf: profilePicURL!) as! Data)
            self.profilePic.isHidden = false
        } else {
            self.signInButton.isHidden = false
            signOutButton.isHidden = true
            self.welcomeLabel.text = "Sign in, stranger!"
            self.profilePic.image = nil
            self.profilePic.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshInterface()
        (UIApplication.shared.delegate as! AppDelegate).signInCallback = refreshInterface
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Check if user is signed in

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

