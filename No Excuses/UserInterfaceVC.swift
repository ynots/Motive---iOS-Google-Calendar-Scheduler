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
    private let cal = Calendar.current
    private var dF: DateFormatter?
    private var weekStartDate: Date?
    private var weekEndDate: Date?
    private var fromTime: Date?
    private var toTime: Date?
    private var repetitions: Int?
    private var sessionLengthHours: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.dF == nil) {
            self.dF = DateFormatter()
            self.dF?.dateFormat = "MM/dd/yy, hh:mm a"
        }
        
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
        if let timesPerWeek: Int = UserDefaults.standard.value(forKey: "repetitions") as! Int? {
            self.repetitions = timesPerWeek
            uiSettingsDisplayView.numPerWeekLbl.text = "\(timesPerWeek)"
        }
        if let fromTime: Date = UserDefaults.standard.value(forKey: "fromTime") as! Date? {
            self.fromTime = fromTime
            setTime(key: "from", time: fromTime)
        }
        if let toTime: Date = UserDefaults.standard.value(forKey: "toTime") as! Date? {
            self.toTime = toTime
            setTime(key: "to", time: toTime)
        }
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
    
    /****************************************
     *
     * View Setup
     *
     *****************************************/
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
        label.font = UIFont.boldSystemFont(ofSize: 50)
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
        button.backgroundColor = UIColor(red: 0, green: 0.4588, blue: 0.8078, alpha: 1.0)
        button.setTitle("Schedule Me!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
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
        button.setTitle("Change Preferences", for: .normal)
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
        button.backgroundColor = UIColor(red: 1, green: 0.4588, blue: 0.4588, alpha: 1.0)
        button.setTitle("Sign Out", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    func signOutButtonPressed (button: UIButton) {
        
        let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out from Google?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive){
            action in
            GIDSignIn.sharedInstance().signOut()
            if let currentUser = GIDSignIn.sharedInstance().currentUser {
                print("\(currentUser.profile.name!) is still signed in.")
            } else {
                print("Signed Out")
                self.performSegue(withIdentifier: "logoutToWelcome", sender: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) {
            action in
            print("Sign out cancelled")
        })
        self.present(alert, animated: true)
        
    }
    
    func setUpSignOutButton() {
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.topAnchor.constraint(equalTo: signOutDescription.bottomAnchor, constant: 12).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /****************************************
     *
     * Setting Display Functions
     *
     *****************************************/
    func setTime(key: String, time: Date) {
        let minute = cal.component(.minute, from: time)
        var hour = cal.component(.hour, from: time)
        
        var ampm: String
        if(hour >= 12) {
            ampm = "PM"
        } else {
            ampm = "AM"
        }
        hour %= 12
        if hour == 0 { hour += 12 }
        
        if (key == "from") {
            uiSettingsDisplayView.fromTimeHourLbl.text = "\(hour)"
            uiSettingsDisplayView.fromTimeMinuteLbl.text = "\(minute)"
            uiSettingsDisplayView.fromAPLbl.text = ampm
        } else {
            uiSettingsDisplayView.toTimeHourLbl.text = "\(hour)"
            uiSettingsDisplayView.toTimeMinuteLbl.text = "\(minute)"
            uiSettingsDisplayView.toAPLbl.text = ampm
        }
    }
    
    /****************************************
     *
     * Google Calendar Functions
     *
     *****************************************/
//    var weekStartDate: Date
//    var weekEndDate: Date
    
    /*
     * Function: fetchEvents
     * Queries Google Cal for a list of events, directs to findFreeTimeSlots through selector
     */
    func fetchEvents () {
        let today = Date()
        let lastSundayMorning = cal.date(from: cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))
        
        // One Week in DateComponents
        let dayComponent = NSDateComponents()
        dayComponent.day = 7
        
        // Week Start = the coming Sunday at midnight
        self.weekStartDate = cal.date(byAdding: dayComponent as DateComponents, to: lastSundayMorning!)!
        print(self.weekStartDate!)
        
        // Week End = the following Sunday at midnight
        self.weekEndDate = cal.date(byAdding: dayComponent as DateComponents, to: weekStartDate!)!
        print(self.weekEndDate!)
        
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
            didFinish: #selector(self.findConflictedDays(ticket:finishedWithObject:error:))
        )
    }
    
    /*
     * Function: findFreeTimeSlots
     * Uses query results from fetchEvents, 
     * sort events in each day of week, check for free time
     * If free time: instantiate array & append to array, else nil
     */
    func findConflictedDays(
        ticket: GTLServiceTicket,
        finishedWithObject response : GTLCalendarEvents,
        error : NSError?)
    {
        // Check Error
        if let error = error {
            // showAlert("Error", message: error.localizedDescription)
            print(error.localizedDescription)
            return
        }
        // Set events from response
        let events = response.items()
        
        // Initialize array of conflicted days
        var conflictedDays: [Int] = []
        
        // if events is not empty, check if event conflicts with alloted time
        if (!(events?.isEmpty)!) {
            for event in events as! [GTLCalendarEvent] {
                // if event conflicts with alloted time, append to conflictedDays array
                if(hasEventConflict(event: event)) {
                    let start : GTLDateTime! = event.start.dateTime ?? event.start.date
                    let day = cal.component(.day, from: start.date)
                    // if conflictedDays array does not contain event.day, append to conflictedDays
                    if !conflictedDays.contains(day) {
                        conflictedDays.append(day)
                    }
                }
            }
        } else {
            print("No events found.")
        }
        // Pass conflictedDays to scheduleSessions
        scheduleSessions(conflicts: conflictedDays)
    }
    
    /*
     * Function: hasEventConflict
     * Parameter: GTLCalendarEvent
     * takes start and end time for event, compares with alloted time range, return true if conflict found
     */
    func hasEventConflict(event: GTLCalendarEvent)-> (Bool) {
        let end: GTLDateTime! = event.end.dateTime ?? event.end.date
        let endHour = cal.component(.hour, from: end.date)
        
        let start : GTLDateTime! = event.start.dateTime ?? event.start.date
        let startHour = cal.component(.hour, from: start.date)
        let eventRange = startHour...endHour
        
        let fromTimeHour = cal.component(.hour, from: self.fromTime!)
        let toTimeHour = cal.component(.hour, from:self.toTime!)
        let allotedRange = fromTimeHour...toTimeHour
        /* 
         * If event ended before alloted Time
         * OR event starts after alloted Time
         * return false (no conflict)
         */
        if (endHour < fromTimeHour
            || startHour > toTimeHour) {
            print("Event out of range")
            return false
        } else if (endHour == fromTimeHour || startHour == toTimeHour) {
            let endMin = cal.component(.minute, from: end.date)
            let startMin = cal.component(.minute, from: start.date)
            let fromMin = cal.component(.minute, from: self.fromTime!)
            let toMin = cal.component(.minute, from: self.toTime!)
            
            if ((endHour == fromTimeHour && endMin < fromMin)
                || (startHour == toTimeHour && startMin > toMin)){
                print("Event out of range")
                return false
            }
        }
        
        // If startHour or endHour is inside the alloted time range,
        if (allotedRange.contains(startHour) || allotedRange.contains(endHour)) {
            print("Event in alloted time")
            return true
        }
        // Else if evenRange contains fromTime or toTime, return true
        else if (eventRange.contains(fromTimeHour) || eventRange.contains(toTimeHour)) {
            print("Event surrounds alloted time")
            return true
        }
        return false
    }
    
    /*
     * Function: scheduleSessions
     * Parameter: conflicts [Int]
     * takes a list of days with conflicts, schedule sessions on days other than conflicted days
     */
    func scheduleSessions(conflicts: [Int]) {
        var availableDays: [Date] = []
        let weekLength = 7
        let weekStart = self.weekStartDate!
        
        // Find available days
        for dayNum in 0 ..< weekLength {
            let date = cal.date(byAdding: .day, value: dayNum, to: weekStart)!
            let day = cal.component(.day, from: date)
            
            if !conflicts.contains(day) {
                availableDays.append(date)
            }
        }
        
        // If there are available days
        if availableDays.count > 0 {
            
            let fromHour = cal.component(.hour, from: self.fromTime!)
            let fromMinute = cal.component(.minute, from: self.fromTime!)
            let toHour = cal.component(.hour, from: self.toTime!)
            let toMinute = cal.component(.minute, from: self.toTime!)
            
            var events: [GTLCalendarEvent] = []
            // if (arrayFreeTimeSlots <= self.repetitions) {
            // foreach freeTimeSlot add event
            if (availableDays.count <= self.repetitions!) {
                for day in availableDays {
                    let event = createEvent(day: day, fromHour: fromHour, fromMinute: fromMinute, toHour: toHour, toMinute: toMinute)
                    events.append(event)
                }
            } else {
                var reps: Int = 0
                while reps < self.repetitions! {
                    let day = availableDays[reps]
                    let event = createEvent(day: day, fromHour: fromHour, fromMinute: fromMinute, toHour: toHour, toMinute: toMinute)
                    events.append(event)
                    reps += 1
                }
            }
            
            if events.count > 0 {
                let calendarId: String = "primary"
                for event in events {
                    let query = GTLQueryCalendar.queryForEventsInsert(withObject: event, calendarId: calendarId)
                    self.service.executeQuery(query!, delegate: self, didFinish: nil)
                }
                let alert = UIAlertController(title: "Scheduled!", message: "\(events.count) sessions are scheduled! Would you like me to show you your Google Calendar?", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Yeah!", style: .default ){
//                    action in
//                    let options = [UIApplicationOpenURLOptionUniversalLinksOnly : true]
//                    UIApplication.shared.open(URL(string: "comgooglecalendar")!, options: options, completionHandler: nil)
//                })
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) {
                    action in
                    print("Schedule created")
                })
                self.present(alert, animated: true)
            } else {
                print("Unexpected error: Events were empty.")
            }
        } else {
            let alert = UIAlertController(title: "Oops!", message: "I couldn't find a free date. Maybe give me another time range to work with!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default) {
                action in
                print("No available time")
            })
            self.present(alert, animated: true)
        }
    }
    
    /*
     * Function: createEvent
     * Parameters: day (Date), fromHour, fromMinute, toHour, toMinute (Ints)
     * Takes day and time, create an new GTLCalendarEvent, return GTLCalendarEvent
     */
    func createEvent (day: Date, fromHour: Int, fromMinute: Int, toHour: Int, toMinute: Int) -> GTLCalendarEvent {
        
        let event = GTLCalendarEvent.init()
        event.summary = "Time to Work It, Big Guy!"
        event.reminders = GTLCalendarEventReminders.init()
        event.reminders.useDefault = true
        var time = day.setTime(hour: fromHour, minute: fromMinute)
        event.start = GTLCalendarEventDateTime.init()
        event.start.dateTime = GTLDateTime.init(date: time, timeZone: NSTimeZone.system)
        time = day.setTime(hour: toHour, minute: toMinute)
        event.end = GTLCalendarEventDateTime.init()
        event.end.dateTime = GTLDateTime.init(date: time, timeZone: NSTimeZone.system)
        return event
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

extension Date {
    func setTime(hour: Int, minute: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components)!
    }
}
