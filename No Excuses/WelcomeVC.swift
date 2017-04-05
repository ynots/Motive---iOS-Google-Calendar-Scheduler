//
//  WelcomeVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255, green: 204/255, blue: 41/255, alpha: 1)
        view.addSubview(appTitleLbl)
        view.addSubview(continueButton)
        setupAppTitleLbl()
        setupContinueButton()
        // Do any additional setup after loading the view.
        
        // Check if user was signed in previously and sign in silently
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    let appTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "NO EXCUSES"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupAppTitleLbl() {
        appTitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appTitleLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appTitleLbl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        appTitleLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Let's Start", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.addTarget(self, action: #selector(continueButtonWasPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupContinueButton() {
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        continueButton.widthAnchor.constraint(equalTo: appTitleLbl.widthAnchor).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func continueButtonWasPressed(button: UIButton) {
        performSegue(withIdentifier: "toSetupIntroSegue", sender: nil)
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
