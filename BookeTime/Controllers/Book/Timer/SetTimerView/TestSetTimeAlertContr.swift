//
//  TestSetTimeAlertContr.swift
//  BookeTime
//
//  Created by Solomon  on 03.02.2023.
//

import UIKit

class TestSetTimeAlertContr: BaseView {
    
    var workingTimeDuration = 0.0
    var breakTimeDuration = 0.0
    var reps = 0
    
    struct Constant {
        static let backgruondAlpha: CGFloat = 0.8
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: Res.fountFutura, size: 30)
        lable.textAlignment = .center
        lable.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return lable
    }()

    private var workingTimePicker = SetTimerView()
    private let breakTimePicker = SetTimerView()
    private let labelPicer = CustomPickerView()
    private let secondlabelPicer = CustomPickerView()
    private let repiatsPicer = SetTimerView()
    
    private let lebelBreak: UILabel = {
        let label = UILabel()
        label.text = "Select interval"
        label.font = UIFont(name: Res.fountFutura, size: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    deinit {
        print("Hi")
    }
    
    private var myTargetView: UIView?
    
    private var title: String
    
    private var massage: String
    
    var viewController: UIViewController?
    
    required init(myTargetView: UIView? = nil, controller: UIViewController? = nil, massage: String, title: String) {
        self.viewController = controller
        self.myTargetView = myTargetView
        self.massage = massage
        self.title = title
        super .init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAlert() {
        
        guard let targetView = viewController?.view else {return}
        
        myTargetView = targetView
        repiatsPicer.hours = []
        for i in 1...20 {
            repiatsPicer.hours.append("\(i)")
        }
        
        backgroundView.frame = targetView.bounds
        targetView.setupView(backgroundView)
        targetView.setupView(alertView)
        
        NSLayoutConstraint.activate([
                
                alertView.topAnchor.constraint(equalTo: targetView.topAnchor, constant: -400),
                alertView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: 40),
                alertView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -40),
                alertView.heightAnchor.constraint(equalToConstant: 340),
                
                titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10),
                titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                titleLabel.widthAnchor.constraint(equalTo: alertView.widthAnchor),
                
                doneButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10),
                doneButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                doneButton.heightAnchor.constraint(equalToConstant: 30),
                doneButton.widthAnchor.constraint(equalToConstant: 80),
                
                labelPicer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
                labelPicer.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                labelPicer.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
                labelPicer.heightAnchor.constraint(equalToConstant: 20),
                
                workingTimePicker.topAnchor.constraint(equalTo: labelPicer.bottomAnchor),
                workingTimePicker.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                workingTimePicker.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
                workingTimePicker.heightAnchor.constraint(equalToConstant: 60),
                
                lebelBreak.topAnchor.constraint(equalTo: workingTimePicker.bottomAnchor, constant: 12),
                lebelBreak.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                lebelBreak.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
                lebelBreak.heightAnchor.constraint(equalToConstant: 25),
                
                secondlabelPicer.topAnchor.constraint(equalTo: lebelBreak.bottomAnchor, constant: 8),
                secondlabelPicer.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                secondlabelPicer.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
                secondlabelPicer.heightAnchor.constraint(equalToConstant: 20),
                
                breakTimePicker.topAnchor.constraint(equalTo: secondlabelPicer.bottomAnchor),
                breakTimePicker.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                breakTimePicker.widthAnchor.constraint(equalTo: workingTimePicker.widthAnchor, multiplier: 2/3),
                breakTimePicker.heightAnchor.constraint(equalToConstant: 60),
                
                repiatsPicer.topAnchor.constraint(equalTo: secondlabelPicer.bottomAnchor),
                repiatsPicer.leadingAnchor.constraint(equalTo: breakTimePicker.trailingAnchor, constant: 20),
                repiatsPicer.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
                repiatsPicer.heightAnchor.constraint(equalToConstant: 60),
           
            ])

        UIView.animate(withDuration: 0.3,animations: {
            self.backgroundView.alpha = Constant.backgruondAlpha
            self.viewController?.navigationItem.leftBarButtonItem?.customView?.alpha = 0.0
            self.viewController?.navigationItem.rightBarButtonItem?.customView?.alpha = 0.0

        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alertView.center = (self.viewController?.view.center)!
                })
            }
        })
        
    }
    
    @objc func dismissAlert() {
                
        guard let targetView = myTargetView else { return }
        
        workingTimeDuration = workingTimePicker.hourseTime + workingTimePicker.minutesTime + workingTimePicker.secondsTime
        
        breakTimeDuration = breakTimePicker.minutesTime + breakTimePicker.secondsTime
        
        reps = Int(repiatsPicer.hourseTime / 3600)
        
        UIView.animate(withDuration: 0.3,animations: {
            self.viewController?.navigationItem.leftBarButtonItem?.customView?.alpha = 1.0
            self.viewController?.navigationItem.rightBarButtonItem?.customView?.alpha = 1.0

            self.alertView.frame = CGRect(x: 40, y: targetView.frame.height, width: targetView.frame.width - 80, height: 340)

        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.viewController?.viewDidLoad()

                    }
                })
            }
        })
    }
    
}

extension TestSetTimeAlertContr {
    override func setupViews() {
        
        breakTimePicker.numberOf = 3
        repiatsPicer.numberOf = 1
        secondlabelPicer.secondsLabel.text = "Repeats".uppercased()
        
        alertView.setupView(titleLabel)
        alertView.setupView(doneButton)
        alertView.setupView(workingTimePicker)
        alertView.setupView(labelPicer)
        alertView.setupView(lebelBreak)
        alertView.setupView(secondlabelPicer)
        alertView.setupView(breakTimePicker)
        alertView.setupView(repiatsPicer)
        doneButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        titleLabel.text = title
        
    }
    
}
