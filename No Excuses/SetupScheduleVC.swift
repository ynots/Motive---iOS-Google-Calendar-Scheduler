//
//  SetupScheduleVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit
import GoogleAPIClient

class SetupScheduleVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        view.addSubview(signOutButton)
        setUpSignOutButton()
        
        // Do any additional setup after loading the view.
    }
    
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
    
    func signOutButtonPressed (button: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            print("\(currentUser.profile.name!) is still signed in.")
        } else {
            print("Signed Out")
        }
    }
    
    func setUpSignOutButton() {
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
