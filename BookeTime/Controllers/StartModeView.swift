//
//  StartModeView.swift
//  BookeTime
//
//  Created by Solomon  on 24.01.2023.
//

import UIKit

class StartModeView: BaseView {
    
    let subView: UIView = {
       let view  = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Res.fountFutura, size: 20)
        label.textColor = .gray
        return label
    }()
    
    let subLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Res.fountFutura, size: 12)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    required init(title: String, imageName: String, info: String) {
        super.init(frame: CGRect())
        
        image.image = UIImage(named: imageName)
        titleLabel.text = title
        subLable.text = info
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        return image
    }()
    
}

extension StartModeView {
    override func setupViews() {
        
        setupView(subView)
        setupView(image)
        setupView(titleLabel)
        setupView(subLable)
        
    }
    override func constaintViews() {
        
        NSLayoutConstraint.activate([
            subView.centerYAnchor.constraint(equalTo: centerYAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subView.widthAnchor.constraint(equalToConstant: 50),
            subView.heightAnchor.constraint(equalToConstant: 50),
            
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalToConstant: 70),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            subLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            subLable.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            subLable.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -10),
            subLable.heightAnchor.constraint(equalToConstant: 80)
        
            ])
        
    }
    override func configureAppearance() {
        layer.cornerRadius = 15
        backgroundColor = #colorLiteral(red: 0.7776397467, green: 0.7776397467, blue: 0.7776397467, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 5, height: 4)
        layer.shadowRadius = 5
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("Hello world")
    }
}
