//
//  BaseViewController.swift
//  BookeTime
//
//  Created by Solomon  on 24.01.2023.
//

import UIKit

enum NavBarPosition {
    
    case left
    case right
    
}

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        constaintViews()
        configureAppearance()
    }
    
}
@objc extension BaseController {
    func setupViews() {
        
    }
    func constaintViews() {
        
    }
    func configureAppearance() {
        
    }
    func navBarLeftButtontHandler() {
        print("NavBar left button tapped")
    }
    
    func navBarRightButtontHandler() {
        print("NavBar right button tapped")
    }
    
}
extension BaseController {
    func addNavBarButton(at position: NavBarPosition, with title: String) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.titleLabel?.font = UIFont(name: Res.fountFutura, size: 17)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 10
        
        switch position {
        case .left:
            button.addTarget(self, action: #selector(navBarLeftButtontHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarRightButtontHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
}

