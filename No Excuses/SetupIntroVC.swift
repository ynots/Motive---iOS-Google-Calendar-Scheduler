//
//  SetupIntroVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit
import GoogleAPIClient

class SetupIntroVC: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 127/255, green: 71/255, blue: 221/225, alpha: 1)
        view.addSubview(signInButton)
        view.addSubview(pageTitle)
        setUpSignInButton()
        setupPageTitle()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Hi, there!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupPageTitle() {
        pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        pageTitle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        pageTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.contentHorizontalAlignment = .left
        button.setTitle("Sign In with Google", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        // Set image in button
        let btnImg = UIImage(named: "Google-G.png")
        button.setImage(btnImg, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.widthAnchor.constraint(equalTo: button.widthAnchor, constant: -20)
        
        // Set padding in button
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: -70, bottom: 7, right: 7)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -70, bottom: 0, right: 0)
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
    
    func setUpSignInButton() {
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
