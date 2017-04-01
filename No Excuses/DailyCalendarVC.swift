//
//  DailyCalendarVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-03-31.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class DailyCalendarVC: UIViewController {

    @IBOutlet weak var welcomeMessageLabel: UILabel!
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBAction func signOutWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        performSegue(withIdentifier: "signOutToMain", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeMessage = "Welcome to your revamped day"
        welcomeMessageLabel.text = welcomeMessage
        // Do any additional setup after loading the view.
        
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
