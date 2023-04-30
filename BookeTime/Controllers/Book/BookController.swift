//
//  BookController.swift
//  BookeTime
//
//  Created by Solomon  on 26.01.2023.
//

import UIKit
import AVFoundation

class BookController: BaseController {
    
    let customAlert = TestSetTimeAlertContr(massage: "sdfasdasdfa", title: "sdsf")
    
    var audioPlayer: AVAudioPlayer?
    
    let timerView = TimerView()
    
    var timerDuration = 0.0
    
    var breakTimeDuration = 0.0
    
    var currentRep = 1
    
    func startSection() {
        
        if timerView.workingTimerDuration > 0 {
            timerView.startTimer { _ in
                
                print("work")
                let pathToSound = Bundle.main.path(forResource: "soft-awakening", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    self.audioPlayer = try AVAudioPlayer (contentsOf: url)
                    self.audioPlayer?.play ()
                    if self.timerView.breakTimeDuration > 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            self.timerView.restStartTime { _ in
                                
                                print("break")
                                let pathToSound = Bundle.main.path(forResource: "soft-awakening", ofType: "mp3")!
                                let url = URL(fileURLWithPath: pathToSound)
                                do {
                                    self.audioPlayer = try AVAudioPlayer (contentsOf: url)
                                    self.audioPlayer?.play ()
                                }
                                catch  {
                                    print(error)
                                }
                                // MARK: - Rekurtion
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [self] in
                                    self.configureAppearance()
                                    if currentRep >= customAlert.reps {navBarRightButtontHandler()}
                                    else {
                                        timerView.state = .isRuning
                                        currentRep += 1
                                        startSection()
                                    }
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [self] in
                            self.configureAppearance()
                            if currentRep >= customAlert.reps {navBarRightButtontHandler()}
                            else {
                                timerView.state = .isRuning
                                currentRep += 1
                                startSection()
                            }
                        }
                    }
                }
                catch  {
                    print(error)
                }
            }
        } else {
            self.timerView.restStartTime { _ in
                print("break")
                let pathToSound = Bundle.main.path(forResource: "soft-awakening", ofType: "mp3")!
                let url = URL(fileURLWithPath: pathToSound)
                do {
                    self.audioPlayer = try AVAudioPlayer (contentsOf: url)
                    self.audioPlayer?.play ()
                }
                catch  {
                    print(error)
                }
                // MARK: - Rekurtion
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [self] in
                    self.configureAppearance()
                    if currentRep >= customAlert.reps {navBarRightButtontHandler()}
                    else {
                        timerView.state = .isRuning
                        currentRep += 1
                        startSection()
                    }
                }
            }
        }
    }
    var firtsStart: Bool = true
    
    override func navBarLeftButtontHandler() {
        currentRep = 1
        breakTimeDuration = customAlert.breakTimeDuration
        self.timerView.breakTimeDuration = breakTimeDuration
        if timerView.state == .isStopped {
            if customAlert.workingTimeDuration > 0.0 || customAlert.breakTimeDuration > 0.0{
                if timerView.timerProgress == 0 && firtsStart {
                    firtsStart = false
//                    timerView.startTimer = Int(Date().timeIntervalSince1970)
                    print("current time is \(timerView.currentTime)")
                }
                if timerView.restartgo {
                    self.timerView.restStartTime { _ in
                        print("break")
                        let pathToSound = Bundle.main.path(forResource: "soft-awakening", ofType: "mp3")!
                        let url = URL(fileURLWithPath: pathToSound)
                        do {
                            self.audioPlayer = try AVAudioPlayer (contentsOf: url)
                            self.audioPlayer?.play ()
                        }
                        catch  {
                            print(error)
                        }
                        // MARK: - Rekurtion
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            //                            self.configureAppearance()
                            if self.currentRep >= self.customAlert.reps {self.navBarRightButtontHandler()}
                            else {
                                self.currentRep += 1
                                self.startSection()
                            }
                        }
                    }
                }else {
                    startSection()
                }
            } else {
                timerView.pauseTimer()
            }
        } else {
            timerView.pauseTimer()
        }
        timerView.state = timerView.state == .isRuning ? .isStopped : .isRuning
        
        addNavBarButton(
            at: .left,
            with: timerView.state == .isRuning ? "Pause" : "Start"
        )
    }
    
    override func navBarRightButtontHandler() {
        RealmManager.shared.deleteModel(model: timerView.startTimer)
        timerView.startTimer = 0
        firtsStart = true
        timerView.changeTimeButton.isHidden = false
        timerView.stopTimer(mission: true)
        timerView.state = .isStopped
        
        addNavBarButton(at: .left, with: "Start")
    }
    override func viewWillAppear(_ animated: Bool) {
        timerView.alpha = 0.0
        UIView.animate(withDuration: 0.5,animations: {
            self.timerView.alpha = 1
            self.timerView.center = CGPoint(x: 0, y: 300)
            
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.3, animations: {
                })
            }
        })
    }
    
}

extension BookController {
    
    override func setupViews() {
        navigationController?.navigationItem.leftBarButtonItem?.customView?.alpha = 0.0
        
        customAlert.viewController = self
        
        view.backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 0.7253207781)
        view.setupView(timerView)
        
        timerView.backgroundColor = .white
        timerView.layer.cornerRadius = 15
        
    }
    
    override func constaintViews() {
        
        NSLayoutConstraint.activate([
            
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            timerView.heightAnchor.constraint(equalToConstant: 400),
            
        ])
        
    }
    override func configureAppearance() {
        
        addNavBarButton(
            at: .left,
            with: timerView.state == .isRuning ? "Pause" : "Start"
        )
        addNavBarButton(at: .right, with: "Finish")
        
        timerView.changeTimeButton.addTarget(self, action: #selector(setTimerButtonTapped), for: .touchUpInside)
        timerView.configure(withWorkeTime: customAlert.workingTimeDuration, or: true, progress: timerView.timerProgress)
        
        timerView.callBack = { progress in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navBarRightButtontHandler()
            }
        }
        
    }
    
    @objc func setTimerButtonTapped() {
        
        customAlert.showAlert()
        timerDuration = customAlert.workingTimeDuration
        
        self.timerView.configure(withWorkeTime: timerDuration, or: true, progress: self.timerView.timerProgress)
    }
    
}
