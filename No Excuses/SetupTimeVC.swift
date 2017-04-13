//
//  SetupTimeVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class SetupTimeVC: UIViewController {
    var dateFormatter: DateFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.dateFormatter == nil {
            self.dateFormatter = DateFormatter()
            self.dateFormatter?.dateStyle = .none
            self.dateFormatter?.timeStyle = .short
        }
        
        view.backgroundColor = UIColor(red: 247/255, green: 147/255, blue: 30/255, alpha: 1)
        
        view.addSubview(pageTitle)
        view.addSubview(pageDescription)
        view.addSubview(fromTimeLabel)
        view.addSubview(fromTimeInput)
        view.addSubview(toTimeLabel)
        view.addSubview(toTimeInput)
        view.addSubview(nextButton)
        
        if let fromTime: Date = UserDefaults.standard.value(forKey: "fromTime") as? Date {
            fromTimeInput.text = dateFormatter?.string(from: fromTime)
        }
        
        if let toTime: Date = UserDefaults.standard.value(forKey: "toTime") as? Date {
            toTimeInput.text = dateFormatter?.string(from: toTime)
        }
        
        setupPageTitle()
        setupPageDescription()
        setupFromTimeInput()
        setupFromTimeLabel()
        setupToTimeLabel()
        setupToTimeInput()
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
    
    let pageDescription: UILabel = {
        let label = UILabel()
        label.text = "When are you available to workout? Try to find the time when you are free from your commitments, meals and rest."
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupPageDescription() {
        pageDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageDescription.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 12).isActive = true
        pageDescription.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        pageDescription.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    /*
     * Time Input Section
     */
    let fromTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromTimeLabel() {
        fromTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fromTimeLabel.bottomAnchor.constraint(equalTo: fromTimeInput.topAnchor, constant: -12).isActive = true
        fromTimeLabel.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        fromTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let fromTimeInput: UITextField = {
        let tF = UITextField()
        tF.backgroundColor = .white
        tF.addTarget(self, action: #selector(timeFieldEditing), for: .editingDidBegin)
        tF.translatesAutoresizingMaskIntoConstraints = false
        return tF
    }()
    
    func setupFromTimeInput() {
        fromTimeInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fromTimeInput.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -12).isActive = true
        fromTimeInput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        fromTimeInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    let toTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Until"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToTimeLabel() {
        toTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toTimeLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 12).isActive = true
        toTimeLabel.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        toTimeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let toTimeInput: UITextField = {
        let tF = UITextField()
        tF.backgroundColor = .white
        tF.addTarget(self, action: #selector(timeFieldEditing), for: .editingDidBegin)
        tF.translatesAutoresizingMaskIntoConstraints = false
        return tF
    }()
    
    func setupToTimeInput() {
        toTimeInput.centerXAnchor.constraint(equalTo: fromTimeInput.centerXAnchor).isActive = true
        toTimeInput.topAnchor.constraint(equalTo: toTimeLabel.bottomAnchor, constant: 12).isActive = true
        toTimeInput.widthAnchor.constraint(equalTo: fromTimeInput.widthAnchor).isActive = true
        toTimeInput.heightAnchor.constraint(equalTo: fromTimeInput.heightAnchor).isActive = true
    }
    
    /*
     * Function: timeFieldEditing
     * Parameter: UITextField
     * Called when UITextField starts editing, create datePicker inputView
     */
    
    func timeFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.backgroundColor = .white
        datePickerView.datePickerMode = .time
        datePickerView.minuteInterval = 15
        
        var toFromSwitch: String
        if(sender == fromTimeInput) {
            toFromSwitch = "from"
        } else {
            toFromSwitch = "to"
        }
        
        if(sender == fromTimeInput) {
            toTimeInput.resignFirstResponder()
            datePickerView.addTarget(self, action: #selector(handleFromDatePicker), for: .valueChanged)
        } else {
            fromTimeInput.resignFirstResponder()
            datePickerView.addTarget(self, action: #selector(handleToDatePicker), for: .valueChanged)
        }
        
        sender.inputView = datePickerView
        sender.inputAccessoryView = self.createPickerToolbar(toFromSwitch: toFromSwitch)
    }

    /*
     * Function: createPickerToolbar
     * Returns UIToolbar with Donebutton
     */
    func createPickerToolbar (toFromSwitch: String) -> UIToolbar {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        
        if (toFromSwitch == "from") {
            doneButton.tag = 0
        } else {
            doneButton.tag = 1
        }
        
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        doneButton.tintColor = UIColor.black
        doneButton.accessibilityLabel = "DoneTimePicker"
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }
    
    /*
     * Function: handleFromDatePicker
     * Sets fromTimeInput's text to the selected date
     */
    func handleFromDatePicker(sender: UIDatePicker) {
        fromTimeInput.text = dateFormatter?.string(from: sender.date)
    }
    
    /*
     * Function: handleToDatePicker
     * Sets toTimeInput's text to the selected date
     */
    func handleToDatePicker(sender: UIDatePicker) {
        toTimeInput.text = dateFormatter?.string(from: sender.date)
    }

    func doneButtonPressed(sender: UIBarButtonItem) {
        // resign inputView on clicking done
        var picker: UIDatePicker
        if sender.tag == 0 {
            // if "from" tag == 0
            picker = fromTimeInput.inputView as! UIDatePicker
            fromTimeInput.text = dateFormatter?.string(from: picker.date)
            fromTimeInput.resignFirstResponder()
        } else {
            // else "to"
            picker = toTimeInput.inputView as! UIDatePicker
            toTimeInput.text = dateFormatter?.string(from: picker.date)
            toTimeInput.resignFirstResponder()
        }
    }
    
    /*
     * Next Button Section
     */
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next >", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(nextButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    func setupNextButton() {
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func nextButtonWasPressed (button: UIButton) {
        saveSetting()
        performSegue(withIdentifier: "toSetupRepetitionSegue", sender: nil)
    }
    
    /*
     * Function: saveSetting
     * Takes input from time inputs and saves them to UserDefaults
     */
    func saveSetting() {
        print(fromTimeInput.text!)
        var time = dateFormatter?.date(from: fromTimeInput.text!)
        UserDefaults.standard.set(time, forKey: "fromTime")
        print(toTimeInput.text!)
        time = dateFormatter?.date(from: toTimeInput.text!)
        UserDefaults.standard.set(time, forKey: "toTime")
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
