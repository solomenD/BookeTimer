//
//  PersentView.swift
//  BookeTime
//
//  Created by Solomon  on 26.01.2023.
//

import UIKit

extension TimerView {
    final class PercentView: BaseView {
        
        private let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fillProportionally
            view.spacing = 5
            return view
        }()
        
        private let persentLable: UILabel = {
            let lable = UILabel()
            lable.font = UIFont(name: Res.fountFutura, size: 23)
            lable.textColor = .gray
            lable.textAlignment = .center
            
            return lable
        }()
        
        private let subtitleLable: UILabel = {
            let lable = UILabel()
            lable.font = UIFont(name: Res.fountFutura, size: 10)
            lable.textColor = .gray
            lable.textAlignment = .center

            return lable
        }()
        
        override func setupViews() {
            super.setupViews()
             setupView(stackView)
            stackView.addArrangedSubview(persentLable)
            stackView.addArrangedSubview(subtitleLable)
        }
        
        override func constaintViews() {
            super.constaintViews()
            
            NSLayoutConstraint.activate([
                
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
        }
        
        func configure( title: String,with value: Int) {
            subtitleLable.text = title
            persentLable.text = "\(value)%"
        }
    }
}

