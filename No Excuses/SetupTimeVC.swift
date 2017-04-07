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
        view.addSubview(fromTimeInput)
        view.addSubview(nextButton)
        setupPageTitle()
        setupFromTimeInput()
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
    
    /*
     * From Time Section
     */
    let fromTimeInput: UITextField = {
        let tF = UITextField()
        tF.backgroundColor = .white
        tF.addTarget(self, action: #selector(timeFieldEditing), for: .editingDidBegin)
        tF.translatesAutoresizingMaskIntoConstraints = false
        return tF
    }()
    
    func setupFromTimeInput() {
        fromTimeInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fromTimeInput.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fromTimeInput.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        fromTimeInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func timeFieldEditing(sender: UITextField) {
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.backgroundColor = .white
        datePickerView.datePickerMode = .time
        datePickerView.minuteInterval = 15
        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
        inputView.addSubview(datePickerView)
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitle("Done", for: .highlighted)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.gray, for:.highlighted)
            
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
        sender.inputView = inputView
    }
    func handleDatePicker(sender: UIDatePicker) {
        let dF = DateFormatter()
        dF.dateStyle = .none
        dF.timeStyle = .short
        fromTimeInput.text = dF.string(from: sender.date)
    }
    
    func doneButtonPressed() {
        // resign inputView on clicking done
        fromTimeInput.resignFirstResponder()
        // toTimeInput.resignFirstResponder()
    }
    
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
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func nextButtonWasPressed (button: UIButton) {
        saveSetting()
        performSegue(withIdentifier: "toSetupRepetitionSegue", sender: nil)
    }
    
    func saveSetting() {
        
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
