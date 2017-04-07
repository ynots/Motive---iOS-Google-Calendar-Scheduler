//
//  UISettingsDisplayView.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-04.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class UISettingsDisplayView: UIView {
    private let rotation = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 127/255, green: 204/255, blue: 41/255, alpha: 1)
        // Create & Add Labels
        self.addSubview(numPerWeekLbl)
        self.addSubview(numPerWeekTitleLbl)
        self.addSubview(fromTimeTitleLbl)
        self.addSubview(fromTimeSeparatorLbl)
        self.addSubview(fromTimeHourLbl)
        self.addSubview(fromTimeMinuteLbl)
        self.addSubview(fromAPLbl)
        self.addSubview(toTimeTitleLbl)
        self.addSubview(toTimeSeparatorLbl)
        self.addSubview(toTimeHourLbl)
        self.addSubview(toTimeMinuteLbl)
        self.addSubview(toAPLbl)
        
        // Setup Labels
        setupNumPerWeekLbl()
        setupNumPerWeekTitleLbl()
        setupFromTimeTitleLbl()
        setupFromTimeSeparatorLbl()
        setupFromTimeHourLbl()
        setupFromTimeMinuteLbl()
        setupFromAPLbl()
        setupToTimeTitleLbl()
        setupToTimeSeparatorLbl()
        setupToTimeHourLbl()
        setupToTimeMinuteLbl()
        setupToAPLbl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let numPerWeekLbl: UILabel = {
        let label = UILabel()
        label.text = "9"
        label.font = UIFont.boldSystemFont(ofSize: 170)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupNumPerWeekLbl() {
        numPerWeekLbl.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -50).isActive = true
        numPerWeekLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    let numPerWeekTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "Times per week"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupNumPerWeekTitleLbl() {
        numPerWeekTitleLbl.leftAnchor.constraint(equalTo: numPerWeekLbl.rightAnchor).isActive = true
        numPerWeekTitleLbl.topAnchor.constraint(equalTo: numPerWeekLbl.topAnchor, constant: 30).isActive = true
    }
    
    let fromTimeTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "FROM"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromTimeTitleLbl() {
        fromTimeTitleLbl.transform = rotation
        fromTimeTitleLbl.leftAnchor.constraint(equalTo: numPerWeekTitleLbl.leftAnchor, constant: -15).isActive = true
        fromTimeTitleLbl.topAnchor.constraint(equalTo: numPerWeekLbl.topAnchor, constant: 80).isActive = true
    }
    
    let fromTimeSeparatorLbl: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromTimeSeparatorLbl() {
        fromTimeSeparatorLbl.centerXAnchor.constraint(equalTo: numPerWeekTitleLbl.centerXAnchor).isActive = true
        fromTimeSeparatorLbl.topAnchor.constraint(equalTo: numPerWeekTitleLbl.bottomAnchor, constant: -7).isActive = true
    }
    
    let fromTimeHourLbl: UILabel = {
        let label = UILabel()
        label.text = "04"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromTimeHourLbl() {
        fromTimeHourLbl.rightAnchor.constraint(equalTo: fromTimeSeparatorLbl.leftAnchor).isActive = true
        fromTimeHourLbl.topAnchor.constraint(equalTo: numPerWeekTitleLbl.bottomAnchor).isActive = true
    }
    
    let fromTimeMinuteLbl: UILabel = {
        let label = UILabel()
        label.text = "44"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromTimeMinuteLbl() {
        fromTimeMinuteLbl.leftAnchor.constraint(equalTo: fromTimeSeparatorLbl.rightAnchor).isActive = true
        fromTimeMinuteLbl.topAnchor.constraint(equalTo: numPerWeekTitleLbl.bottomAnchor).isActive = true
    }
    
    let fromAPLbl: UILabel = {
        let label = UILabel()
        label.text = "AM"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupFromAPLbl() {
        fromAPLbl.transform = rotation
        fromAPLbl.rightAnchor.constraint(equalTo: numPerWeekTitleLbl.rightAnchor, constant: 12).isActive = true
        fromAPLbl.topAnchor.constraint(equalTo: numPerWeekTitleLbl.bottomAnchor, constant: 9).isActive = true
    }
    
    let toTimeTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "UNTIL"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToTimeTitleLbl() {
        toTimeTitleLbl.transform = rotation
        toTimeTitleLbl.leftAnchor.constraint(equalTo: numPerWeekTitleLbl.leftAnchor, constant: -15).isActive = true
        toTimeTitleLbl.topAnchor.constraint(equalTo: fromTimeHourLbl.bottomAnchor, constant: 15).isActive = true
    }
    
    let toTimeSeparatorLbl: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToTimeSeparatorLbl() {
        toTimeSeparatorLbl.centerXAnchor.constraint(equalTo: numPerWeekTitleLbl.centerXAnchor).isActive = true
        toTimeSeparatorLbl.topAnchor.constraint(equalTo: fromTimeSeparatorLbl.bottomAnchor).isActive = true
    }
    
    let toTimeHourLbl: UILabel = {
        let label = UILabel()
        label.text = "99"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToTimeHourLbl() {
        toTimeHourLbl.rightAnchor.constraint(equalTo: toTimeSeparatorLbl.leftAnchor).isActive = true
        toTimeHourLbl.topAnchor.constraint(equalTo: fromTimeHourLbl.bottomAnchor, constant: -4).isActive = true
    }
    
    let toTimeMinuteLbl: UILabel = {
        let label = UILabel()
        label.text = "99"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToTimeMinuteLbl() {
        toTimeMinuteLbl.leftAnchor.constraint(equalTo: toTimeSeparatorLbl.rightAnchor).isActive = true
        toTimeMinuteLbl.topAnchor.constraint(equalTo: toTimeHourLbl.topAnchor).isActive = true
    }
    
    let toAPLbl: UILabel = {
        let label = UILabel()
        label.text = "AM"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupToAPLbl() {
        toAPLbl.transform = rotation
        toAPLbl.rightAnchor.constraint(equalTo: numPerWeekTitleLbl.rightAnchor, constant: 12).isActive = true
        toAPLbl.topAnchor.constraint(equalTo: fromTimeHourLbl.bottomAnchor, constant: 9).isActive = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
