//
//  SetTimerView.swift
//  BookeTime
//
//  Created by Solomon  on 28.01.2023.
//

import UIKit

//enum TimePosition {
//    case second
//    case minute
//    case hour
//}

class SetTimerView: BaseView{
        
    var hourseTime = 0.0
    var minutesTime = 0.0
    var secondsTime = 0.0
    
    var numberOf: Int = 3
    
    var minutes:[String] = Array()
    var hours:[String] = Array()
    var seconds:[String] = Array()
    
    private let pickerTimer = UIPickerView()
    
    private func configure() {
        for i in 0...59 {
            minutes.append("\(i)")
            seconds.append("\(i)")
        }
        for i in 0...24 {
            hours.append("\(i)")
        }
    }
    
}

extension SetTimerView {
    
    override func setupViews() {
        configure()
        pickerTimer.backgroundColor = #colorLiteral(red: 0.7937343717, green: 0.7937343717, blue: 0.7937343717, alpha: 1)
        pickerTimer.layer.cornerRadius = 10
        setupView(pickerTimer)
        pickerTimer.delegate = self
        pickerTimer.dataSource = self
        
        
    }
    override func constaintViews() {
        
        NSLayoutConstraint.activate([
        
            pickerTimer.topAnchor.constraint(equalTo: topAnchor),
            pickerTimer.widthAnchor.constraint(equalTo: widthAnchor),
            pickerTimer.heightAnchor.constraint(equalTo: heightAnchor)
            
            
        
        ])
        
    }
    override func configureAppearance() {
    
    }
}

extension SetTimerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return hours[row]
        }
        else if component == 1 {
            return minutes[row]
        }
        else if component == 2{
            return seconds[row]
        }
        
        return ""
    }
    
}

extension SetTimerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        numberOf
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return hours.count
        }
        else if component == 1{
            return minutes.count
        }
        else if component == 2{
            return seconds.count
        }
        
        return minutes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                
        switch component {
        case 0:
            hourseTime = Double(hours[row])! * 3600
        case 1:
            minutesTime = Double(minutes[row])! * 60
        case 2:
            secondsTime = Double(seconds[row])!
        default: break
            
        }
    }
}
