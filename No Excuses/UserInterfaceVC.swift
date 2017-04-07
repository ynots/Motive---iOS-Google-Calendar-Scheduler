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
    private let service = GTLServiceCalendar()
    private var listOfCalendars: Any?
    private var listOfEvents: Any?
    private var startTime: NSDate?
    private var endTime: NSDate?
    private var timesPerWeek: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timesPerWeek = UserDefaults.standard.value(forKey: "repetitions") as! Int?
        
        // Scroll View
        view.addSubview(baseScrollView)
        setupScrollView()
        
        // Title Section
        baseScrollView.addSubview(titleView)
        titleView.addSubview(welcomeMessage)
        titleView.addSubview(welcomeDescription)
        setupTitleView()
        setupWelcomeMessage()
        setupWelcomeDescription()
        
        // UI Settings Display Section
        baseScrollView.addSubview(uiSettingsDisplayView)
        uiSettingsDisplayView.numPerWeekLbl.text = "\(timesPerWeek!)"
        setupSettingsDisplayView()
        
        // Create Schedule Section
        baseScrollView.addSubview(createView)
        createView.addSubview(createDescription)
        createView.addSubview(createButton)
        setupCreateView()
        setupCreateDescription()
        setupCreateButton()
        
        // Settings Overview Section
        baseScrollView.addSubview(settingsView)
        settingsView.addSubview(editDescription)
        settingsView.addSubview(settingsButton)
        setupSettingsView()
        setupEditDescription()
        setupSettingsButton()
        
        // Sign Out Section
        baseScrollView.addSubview(signOutView)
        signOutView.addSubview(signOutDescription)
        signOutView.addSubview(signOutButton)
        setupSignOutView()
        setupSignOutDescription()
        setUpSignOutButton()
        
        // Initialize Google Calendar Authorizer
        service.authorizer = GIDSignIn.sharedInstance().currentUser.authentication.fetcherAuthorizer()
        // Get user settings
        // Do any additional setup after loading the view.
    }
    
    let baseScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 320, height: 780)
        scrollView.isUserInteractionEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    func setupScrollView() {
        baseScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        baseScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        baseScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        baseScrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    /*
     * Title View
     * Includes: Welcome Message, Welcome Description
     * Height: 172
     */
    let titleView: UIView = {
        let title = UIView()
        title.backgroundColor = UIColor(red: 127/255, green: 204/255, blue: 41/255, alpha: 1)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setupTitleView() {
        titleView.centerXAnchor.constraint(equalTo: baseScrollView.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: baseScrollView.topAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 172).isActive = true
    }
    
    let welcomeMessage: UILabel = {
        let label = UILabel()
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            label.text = "Hi, \(currentUser.profile.givenName!) !"
        }
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = NSTextAlignment.left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupWelcomeMessage() {
        welcomeMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeMessage.topAnchor.constraint(equalTo: baseScrollView.topAnchor, constant: 50).isActive = true
        welcomeMessage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        welcomeMessage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let welcomeDescription: UILabel = {
        let label = UILabel()
        label.text = "Just to make sure, these are your requirements, correct?"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupWelcomeDescription() {
        welcomeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeDescription.topAnchor.constraint(equalTo: welcomeMessage.bottomAnchor, constant: 7).isActive = true
        welcomeDescription.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        welcomeDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    /*
     * Settings Display View
     * Includes: uiSettingsDisplayView
     * Height: 200
     */
    let uiSettingsDisplayView: UISettingsDisplayView = {
        let display = UISettingsDisplayView()
        display.translatesAutoresizingMaskIntoConstraints = false
        return display
    }()
    
    func setupSettingsDisplayView() {
        uiSettingsDisplayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uiSettingsDisplayView.topAnchor.constraint(equalTo: welcomeDescription.bottomAnchor).isActive = true
        uiSettingsDisplayView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        uiSettingsDisplayView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    /*
     * Create View
     * Includes: Create Description, Create Button
     * Height: 134
     */
    let createView: UIView = {
        let sView = UIView()
        sView.backgroundColor = UIColor(red: 127/255, green: 204/255, blue: 41/255, alpha: 0.85)
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    func setupCreateView() {
        createView.centerXAnchor.constraint(equalTo: baseScrollView.centerXAnchor).isActive = true
        createView.topAnchor.constraint(equalTo: uiSettingsDisplayView.bottomAnchor).isActive = true
        createView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor).isActive = true
        createView.heightAnchor.constraint(equalToConstant: 134).isActive = true
    }
    
    let createDescription: UILabel = {
        let label = UILabel()
        label.text = "Let's me make that schedule for you!"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupCreateDescription() {
        createDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createDescription.topAnchor.constraint(equalTo: uiSettingsDisplayView.bottomAnchor).isActive = true
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
        fetchEvents()
    }
    
    func setupCreateButton () {
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: createDescription.bottomAnchor, constant: 12).isActive = true
        createButton.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /*
     * Settings View
     * Includes: Settings Description, Edit Settings Button
     * Height: 134
     */
    let settingsView: UIView = {
        let sView = UIView()
        sView.backgroundColor = UIColor(red: 127/255, green: 204/255, blue: 41/255, alpha: 0.75)
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    func setupSettingsView() {
        settingsView.centerXAnchor.constraint(equalTo: baseScrollView.centerXAnchor).isActive = true
        settingsView.topAnchor.constraint(equalTo: createView.bottomAnchor).isActive = true
        settingsView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 134).isActive = true
    }
    
    let editDescription: UILabel = {
        let label = UILabel()
        label.text = "Edit your settings here!"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupEditDescription() {
        editDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editDescription.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 12).isActive = true
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
    
    /*
     * Sign Out View
     * Includes: Sign Out Description, Sign Out Button
     * Height: 146
     */
    let signOutView: UIView = {
        let sView = UIView()
        sView.backgroundColor = UIColor(red: 127/255, green: 204/255, blue: 41/255, alpha: 0.65)
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    func setupSignOutView() {
        signOutView.centerXAnchor.constraint(equalTo: baseScrollView.centerXAnchor).isActive = true
        signOutView.topAnchor.constraint(equalTo: settingsView.bottomAnchor).isActive = true
        signOutView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor).isActive = true
        signOutView.heightAnchor.constraint(equalToConstant: 146).isActive = true
    }
    
    let signOutDescription: UILabel = {
        let label = UILabel()
        label.text = "Sign out of your Google Account"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupSignOutDescription() {
        signOutDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutDescription.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 12).isActive = true
        signOutDescription.widthAnchor.constraint(equalTo: welcomeMessage.widthAnchor).isActive = true
        signOutDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }

    let signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitle("Sign Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
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
        signOutButton.topAnchor.constraint(equalTo: signOutDescription.bottomAnchor, constant: 12).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /****************************************
     *
     * Google Calendar Functions
     *
     *****************************************/
    
    /*
     * Function: fetchEvents
     * Queries Google Cal for a list of events, directs to findFreeTimeSlots through selector
     */
    func fetchEvents () {
        // Set Start date to last Sunday's 7:00 am
        var weekStartDate: Date {
            return NSCalendar.current.date(from: NSCalendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        }
        // Set End date to the coming Sunday's 7:00 am
        var weekEndDate: Date {
            let dayComponent = NSDateComponents()
            dayComponent.day = 7
            return NSCalendar.current.date(byAdding: dayComponent as DateComponents, to: weekStartDate)!
        }
        
        // Build GCal query string
        let query = GTLQueryCalendar.queryForEventsList(withCalendarId: "primary")
        query?.timeMin = GTLDateTime(date: weekStartDate, timeZone: NSTimeZone.local)
        query?.timeMax = GTLDateTime(date: weekEndDate, timeZone: NSTimeZone.local)
        query?.singleEvents = true
        query?.orderBy = kGTLCalendarOrderByStartTime
        service.executeQuery(
            query!,
            delegate: self,
            // selector after finish query
            didFinish: #selector(self.findFreeTimeSlots(ticket:finishedWithObject:error:))
        )
    }
    
    /*
     * Function: findFreeTimeSlots
     * Uses query results from fetchEvents, 
     * sort events in each day of week, check for free time
     * If free time: instantiate array & append to array, else nil
     */
    func findFreeTimeSlots(
        ticket: GTLServiceTicket,
        finishedWithObject response : GTLCalendarEvents,
        error : NSError?) {
            // Check Error
            if let error = error {
                // showAlert("Error", message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            
            var eventString = ""
            let events = response.items()
            if (!(events?.isEmpty)!) {
                for event in events as! [GTLCalendarEvent] {
                    let start : GTLDateTime! = event.start.dateTime ?? event.start.date
                    let startString = DateFormatter.localizedString(
                        from: start.date,
                        dateStyle: .short,
                        timeStyle: .short
                    )
                    let end : GTLDateTime! = event.end.dateTime ?? event.end.date
                    let endString = DateFormatter.localizedString(
                        from: end.date,
                        dateStyle: .short,
                        timeStyle: .short
                    )
                    eventString += "\(startString) - \(endString) \(event.summary!)\n"
                }
            } else {
                eventString = "No upcoming events found."
            }
        print(eventString)
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
//
//extension UIView {
//    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
//        self.layer.addSublayer(border)
//    }
//}
