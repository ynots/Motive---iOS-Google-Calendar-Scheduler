//
//  ViewController.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-03-28.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            label.text = "Welcome back, \(currentUser.profile.name!)"
        } else {
            label.text = "Sign in, Stranger!"
        }
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            let profilePicURL = currentUser.profile.imageURL(withDimension: 175)
            imageView.image = UIImage(data: NSData(contentsOf: profilePicURL!) as! Data)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.green
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.blue
        button.setTitle("Sign Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    func signInButtonPressed (button: UIButton) {
        GIDSignIn.sharedInstance().signIn()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            print("\(currentUser.profile.name!) has signed in.")
        } else {
            print("no users")
        }
    }
    
    func signOutButtonPressed (button: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            print("\(currentUser.profile.name!) is still signed in.")
        } else {
            print("Signed Out")
        }
    }
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    func signOutWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        refreshInterface()
    }
    
    func refreshButtonWasPressed(_ sender: Any) {
        refreshInterface()
        if (GIDSignIn.sharedInstance().currentUser != nil) {
            performSegue(withIdentifier: "loginToDailyCalendar", sender: nil)
        }
    }
    func refreshInterface() {
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
        
        view.addSubview(welcomeLabel)
        view.addSubview(profileImageView)
        view.addSubview(signInButton)
        view.addSubview(signOutButton)
        setUpWelcomeLabel()
        setUpProfilePic()
        setUpSignInButton()
        setUpSignOutButton()
        
        // refreshInterface()
        // (UIApplication.shared.delegate as! AppDelegate).signInCallback = refreshInterface
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Check if user is signed in

    }
    
    func setUpWelcomeLabel() {
        // x, y, width, height constraints
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 70).isActive = true
        welcomeLabel.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpProfilePic() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpSignInButton() {
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpSignOutButton() {
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 12).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}





























