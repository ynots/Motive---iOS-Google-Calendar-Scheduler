//
//  SetupTimeVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class SetupTimeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 247/255, green: 147/255, blue: 30/255, alpha: 1)
        
        view.addSubview(pageTitle)
        view.addSubview(nextButton)
        setupPageTitle()
        setupNextButton()
        // Do any additional setup after loading the view.
    }
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Time"
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
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next >", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(nextButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    func setupNextButton() {
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func nextButtonWasPressed (button: UIButton) {
        performSegue(withIdentifier: "toSetupRepetitionSegue", sender: nil)
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
