//
//  UserInterfaceVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit
import GoogleAPIClient

class UserInterfaceVC: UIViewController {
    private var listOfCalendars: Any?
    private var listOfEvents: Any?
    private var startTime: NSDate?
    private var endTime: NSDate?
    private var timesPerWeek: NSNumber?
    
    @IBOutlet var uiSettingsDisplayView: UISettingsDisplayView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255, green: 204/255, blue: 41/255, alpha: 1)
        view.addSubview(welcomeMessage)
        view.addSubview(welcomeDescription)
        uiSettingsDisplayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uiSettingsDisplayView)
        view.addSubview(editDescription)
        view.addSubview(settingsButton)
        view.addSubview(createDescription)
        view.addSubview(createButton)
        view.addSubview(signOutButton)
        setupWelcomeMessage()
        setupWelcomeDescription()
        setupSettingsDisplayView()
        setupEditDescription()
        setupSettingsButton()
        setupCreateDescription()
        setupCreateButton()
        setUpSignOutButton()
        
        // Get user settings
        
        // Do any additional setup after loading the view.
    }
    
    let welcomeMessage: UILabel = {
        let label = UILabel()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            label.text = "Hi, \(currentUser.profile.givenName!) !"
        }
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupWelcomeMessage() {
        welcomeMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        welcomeMessage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        welcomeMessage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let welcomeDescription: UILabel = {
        let label = UILabel()
        label.text = "Just to make sure, these are your requirements, correct?"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupWelcomeDescription() {
        welcomeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeDescription.topAnchor.constraint(equalTo: welcomeMessage.bottomAnchor, constant: 12).isActive = true
        welcomeDescription.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        welcomeDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupSettingsDisplayView() {
        let rotation = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        uiSettingsDisplayView.fromLabel?.transform = rotation
        uiSettingsDisplayView.toLabel?.transform = rotation
        uiSettingsDisplayView.fromAPLabel?.transform = rotation
        uiSettingsDisplayView.toAPLabel?.transform = rotation
        uiSettingsDisplayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiSettingsDisplayView.topAnchor.constraint(equalTo: welcomeDescription.bottomAnchor, constant: 12).isActive = true
        uiSettingsDisplayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        uiSettingsDisplayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    
    let editDescription: UILabel = {
        let label = UILabel()
        label.text = "If you want to change any of these settings, you can edit them here!"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupEditDescription() {
        editDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editDescription.topAnchor.constraint(equalTo: uiSettingsDisplayView.bottomAnchor, constant: 30).isActive = true
        editDescription.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        editDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Edit Settings", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    func settingsButtonPressed (button: UIButton) {
        performSegue(withIdentifier: "toSettingsSegue", sender: nil)
    }
    
    func setupSettingsButton () {
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.topAnchor.constraint(equalTo: editDescription.bottomAnchor, constant: 12).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: editDescription.widthAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let createDescription: UILabel = {
        let label = UILabel()
        label.text = "If those are correct, let me schedule  for you!"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupCreateDescription() {
        createDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createDescription.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 30).isActive = true
        createDescription.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        createDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Create Schedule", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        return button
    }()
    
    func createButtonPressed (button: UIButton) {
        print("Create Schedule")
    }
    
    func setupCreateButton () {
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: createDescription.bottomAnchor, constant: 12).isActive = true
        createButton.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
            performSegue(withIdentifier: "logoutToSetupIntro", sender: nil)
        }
    }
    
    func setUpSignOutButton() {
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 30).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /****************************************
     Google Calendar Functions
     */
    func fetchEvents () {
        // use listOfCalendars
        // get events from each of calendars
        // return lEvents
    }
    
    func findFreeTimeSlots(loe: Any) {
        // for each day of week, check if timeRange have a 2-hr free block
        // if free, push day to arrayFreeTimeSlots
        // return arrayFreeTimeSlots
    }
    
    func scheduleSessions() {
        // if (arrayFreeTimeSlots <= self.numPerWeek) {
        // foreach freeTimeSlot add event
        // else { 
        // check for consecutiveDays in array
        // avoid consecutive days
        // schedule free time slots
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
