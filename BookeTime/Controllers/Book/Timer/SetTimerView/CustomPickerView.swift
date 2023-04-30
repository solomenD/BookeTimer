//
//  CustomPickerView.swift
//  BookeTime
//
//  Created by Solomon  on 31.01.2023.
//

import UIKit

class CustomPickerView: BaseView {
    
     var timeStrings = ["Hours", "Minutes", "Seconds"]
    
    private let hoursLabel: UILabel = {
        let label  = UILabel()
        label.font = UIFont(name: Res.fountFutura, size: 12)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5000000596, alpha: 1)
        return label
    }()
    
    private let minutesLabel: UILabel = {
        let label  = UILabel()
        label.font = UIFont(name: Res.fountFutura, size: 12)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5000000596, alpha: 1)
        return label
    }()
    
    let secondsLabel: UILabel = {
        let label  = UILabel()
        label.font = UIFont(name: Res.fountFutura, size: 12)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5000000596, alpha: 1)
        return label
    }()
    
    private let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
//        view.spacing = 10
        return view
    }()
    
}

extension CustomPickerView {
    
    override func setupViews() {
        hoursLabel.text = timeStrings[0]
        minutesLabel.text = timeStrings[1]
        secondsLabel.text = timeStrings[2]
        let masiveLabel = [hoursLabel,minutesLabel,secondsLabel]
        
        setupView(stackView)
        masiveLabel.forEach (stackView.addArrangedSubview)
        
    }
    
    override func constaintViews() {
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    override func configureAppearance() {
        
    }
    
}
