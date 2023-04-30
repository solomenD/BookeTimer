//
//  ViewController.swift
//  BookeTime
//
//  Created by Solomon  on 24.01.2023.
//

import UIKit

class ViewController: BaseController {
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: Res.fountFutura, size: 40)
        return button       
    }()
    
    private let anoterView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let progressView = ProgressView()
    
    func configure(with duration: Double, progress: Double) {

        let tempCurrentValue = progress > duration ? duration : progress
        let goalValueDevider = duration == 0 ? 1 : duration
        let percent = tempCurrentValue / goalValueDevider

        progressView.drawProgress(with: CGFloat(percent), circleLayers: false)
        
    }

    private func configSender(view: StartModeView, action: Selector){
        let gesture = UITapGestureRecognizer(target: self, action:  action)
        view.addGestureRecognizer(gesture)
    }

}

@objc extension ViewController {
    
    override func setupViews() {
        
        configure(with: 0.0, progress: 0)
        view.backgroundColor = .white
        
        view.setupView(anoterView)
        
        anoterView.setupView(progressView)
        anoterView.setupView(startButton)
        
    }
    override func constaintViews() {
        
        NSLayoutConstraint.activate([
            
            anoterView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            anoterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            anoterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            anoterView.heightAnchor.constraint(equalToConstant: 300),
            
            progressView.topAnchor.constraint(equalTo: anoterView.topAnchor,constant: 40),
            progressView.leadingAnchor.constraint(equalTo: anoterView.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: anoterView.trailingAnchor, constant: -40),
            progressView.bottomAnchor.constraint(equalTo: anoterView.bottomAnchor,constant: 20),
            
            startButton.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
            
        ])
        
    }
    override func configureAppearance() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
    }
    
    func startButtonTapped() {
        let bookController = BookController()
        //AddAnimation
        UIView.animate(withDuration: 0.6,animations: {
            self.anoterView.alpha = 0.0
            self.startButton.alpha = 0.0
            self.view.backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 0.7253207781)
            self.anoterView.center = CGPoint(x: 200, y: 270)

        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.navigationController?.pushViewController(bookController, animated: false)
                })
            }
        })
        
        
    }
}

