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
        view.backgroundColor = UIColor(red: 87/255, green: 71/255, blue: 221/225, alpha: 1)
        view.addSubview(pageTitle)
        view.addSubview(introLabel)
        view.addSubview(smileyFace)
        view.addSubview(briefingLabel)
        view.addSubview(instructionLabel)
        view.addSubview(signInButton)
        setupPageTitle()
        setupIntroLabel()
        setupSmileyFace()
        setupBriefingLabel()
        setupInstructionLabel()
        setUpSignInButton()
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
    
    let introLabel: UILabel = {
        let label = UILabel()
        label.text = "I'm your new personal assistant, Ynot. I will schedule all your workout sessions for you every week using your Google Calendars!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupIntroLabel() {
        introLabel.centerXAnchor.constraint(equalTo: pageTitle.centerXAnchor).isActive = true
        introLabel.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 12).isActive = true
        introLabel.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        introLabel.heightAnchor.constraint(equalTo: pageTitle.heightAnchor).isActive = true
    }
    
    let smileyFace: UILabel = {
        let label = UILabel()
        label.text = ":)"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupSmileyFace() {
        smileyFace.centerXAnchor.constraint(equalTo: pageTitle.centerXAnchor).isActive = true
        smileyFace.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 12).isActive = true
        smileyFace.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        smileyFace.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    let briefingLabel: UILabel = {
        let label = UILabel()
        label.text = "I will only use the calendars you give me access to find the free time slots you have. \n\n Don't worry! \n\n I won't check where I'm not supposed to!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupBriefingLabel() {
        briefingLabel.centerXAnchor.constraint(equalTo: pageTitle.centerXAnchor).isActive = true
        briefingLabel.topAnchor.constraint(equalTo: smileyFace.bottomAnchor, constant: 12).isActive = true
        briefingLabel.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        briefingLabel.heightAnchor.constraint(equalTo:smileyFace.heightAnchor).isActive = true
    }
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "So let's start by giving me some instructions to start scheduling you to become who you want to be!"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupInstructionLabel () {
        instructionLabel.centerXAnchor.constraint(equalTo: pageTitle.centerXAnchor).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: briefingLabel.bottomAnchor, constant: 24).isActive = true
        instructionLabel.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        instructionLabel.heightAnchor.constraint(equalTo: pageTitle.heightAnchor).isActive = true
    }
    
    let signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.contentHorizontalAlignment = .left
        button.setTitle("Log In with Google", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        // Set image in button
        let btnImg = UIImage(named: "Google-G.png")
        button.setImage(btnImg, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.widthAnchor.constraint(equalTo: button.widthAnchor, constant: -30)
        
        // Set padding in button
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: -70, bottom: 12, right: 12)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -95, bottom: 0, right: 0)
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
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
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
