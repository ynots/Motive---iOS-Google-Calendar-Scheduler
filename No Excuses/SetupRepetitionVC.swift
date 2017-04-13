//
//  SetupRepetitionVC.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-02.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class SetupRepetitionVC: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 133/255, blue: 188/255, alpha: 1)
        
        view.addSubview(pageTitle)
        view.addSubview(pageDescription)
        view.addSubview(repetitionInput)
        repetitionInput.delegate = self
        repetitionInput.inputAccessoryView = self.createPickerToolbar()
        
        view.addSubview(nextButton)
        
        setupPageTitle()
        setupPageDescription()
        setupRepetitionInput()
        setupNextButton()
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: repetitionInput.frame.size.height - width, width:  repetitionInput.frame.size.width, height: repetitionInput.frame.size.height)
        
        border.borderWidth = width
        repetitionInput.layer.addSublayer(border)
        repetitionInput.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
        
        if let repetition: Int = UserDefaults.standard.value(forKey: "repetitions") as! Int? {
            repetitionInput.text = "\(repetition)"
        }
    }
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Repetition"
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
        label.text = "How many times per week should I schedule workouts for you?"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
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
    
    let repetitionInput: UITextField = {
        let input = UITextField()
        input.keyboardType = UIKeyboardType.numberPad
        input.backgroundColor = UIColor.clear
        input.font = UIFont.boldSystemFont(ofSize: 200)
        input.textColor =  UIColor.white
        input.textAlignment = .center
        input.text = "4"
        input.translatesAutoresizingMaskIntoConstraints = false
        input.borderStyle = .roundedRect
        return input
    }()
    
    /*
     * Function: createPickerToolbar
     * Returns UIToolbar with Donebutton
     */
    func createPickerToolbar () -> UIToolbar {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        doneButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        doneButton.accessibilityLabel = "DoneRepetitionInput"
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }
    
    func doneButtonPressed() {
         repetitionInput.resignFirstResponder()
    }
    
    func setupRepetitionInput () {
        repetitionInput.centerXAnchor.constraint(equalTo: pageTitle.centerXAnchor).isActive = true
        repetitionInput.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        repetitionInput.widthAnchor.constraint(equalTo: pageTitle.widthAnchor).isActive = true
        repetitionInput.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done >", for: .normal)
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
        saveSettings()
        performSegue(withIdentifier: "setupToUISegue", sender: nil)
    }
    
    func saveSettings() {
        let repetitions = Int((repetitionInput.text)!)
        UserDefaults.standard.set(repetitions, forKey: "repetitions")
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
    
    
    /*
     * UITextField Delegate
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}

