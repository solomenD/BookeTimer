//
//  TimerView.swift
//  BookeTime
//
//  Created by Solomon  on 26.01.2023.
//

import UIKit
import RealmSwift

enum TimerState {
    case isRuning
    case isPaused
    case isStopped
}

final class TimerView: BaseView {
    
    private let elapsedTimeLable: UILabel = {
        let lable  = UILabel()
        lable.text = Res.Book.elapsedTime
        lable.font = UIFont(name: Res.fountFutura, size: 14)
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private let elapsedTimeValueLable: UILabel = {
        let lable  = UILabel()
        lable.font = UIFont.boldSystemFont(ofSize: 50)
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private let remainingTimeLable: UILabel = {
        let lable  = UILabel()
        lable.text = Res.Book.remainengTime
        lable.font = UIFont(name: Res.fountFutura, size: 13)
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private let remainingTimeValueLable: UILabel = {
        let lable  = UILabel()
        lable.font = UIFont(name: Res.fountFutura, size: 13)
        lable.textColor = .gray
        lable.textAlignment = .center
        return lable
    }()
    
    private let timeSackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    private let bottomStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillProportionally
        view.spacing = 25
        return view
    }()
    
    private let completedPersentView = PercentView()
    private let remeiningPercentView = PercentView()
    
    private let bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let progressView = ProgressView()
    
     let changeTimeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Time", for: .normal)
        button.titleLabel?.font = UIFont(name: Res.fountFutura, size: 18)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()

    var timer = Timer()
    var timerProgress: CGFloat = 0
    var workingTimerDuration = 0.0
    var breakTimeDuration = 0.0

    var state: TimerState = .isStopped
    var callBack: ((CGFloat) -> Void)?
    
    var srartTimerForLogIn = 0
    var startTimer = 0
    var currentTime = 0
    
    let realm = try! Realm()
    let timeModel = TimeModel()

    func configure(withWorkeTime workDuration: Double, or: Bool ,progress: Double) {
        if or {
            workingTimerDuration = workDuration
        } else {
            breakTimeDuration = workDuration
        }

       let tempCurrentValue = progress > workDuration ? workDuration : progress
       let goalValueDevider = workDuration == 0 ? 1 : workDuration
       let percent = tempCurrentValue / goalValueDevider
       let roundedPercent = Int(round(percent * 100))
       
       elapsedTimeValueLable.text = getDisplayedString(from: Int(tempCurrentValue))
       remainingTimeValueLable.text = getDisplayedString(from: Int(workDuration) - Int(tempCurrentValue))
       completedPersentView.configure(title: Res.Book.completedPercent.uppercased(), with: roundedPercent)
       remeiningPercentView.configure(title: Res.Book.remainingPercent.uppercased(), with: 100 - roundedPercent)
       progressView.drawProgress(with: CGFloat(percent), circleLayers: true)
       
          }

    func startTimer(completion: @escaping (CGFloat) -> Void) {
       timer.invalidate()
        
        if srartTimerForLogIn == 0 {
            srartTimerForLogIn = Int(Date().timeIntervalSince1970)
            timeModel.actualStartTime = srartTimerForLogIn
            RealmManager.shared.saveModel(model: timeModel)
            print (Realm.Configuration.defaultConfiguration.fileURL)
        }
        startTimer = Int(Date().timeIntervalSince1970)
        changeTimeButton.isHidden = true
       timer = Timer.scheduledTimer(withTimeInterval: 0.01,
                                    repeats: true,
                                    block: { [weak self] timer in
           guard let self = self else { return }
           timerProgress += 0.01
           //MARK: - сделать проверку на время начала так что бы даже если через секунду но было актуальный прогресс
           currentTime = Int(Date().timeIntervalSince1970)
             let actualProgress = currentTime - startTimer
           if timerProgress < Double(actualProgress)-1 {
               timerProgress = Double(actualProgress)+1
           }

           if self.timerProgress > self.workingTimerDuration {
               self.timerProgress = self.workingTimerDuration
               timer.invalidate()
               self.stopTimer(mission: true)
               completion(self.timerProgress)
           }


           self.configure(withWorkeTime: self.workingTimerDuration, or: true, progress: self.timerProgress)
       })
        
   }
    
    var restartgo: Bool = false
    
    func restStartTime(completion: @escaping (CGFloat) -> Void) {
        restartgo = true
        
        if srartTimerForLogIn == 0 {
            srartTimerForLogIn = Int(Date().timeIntervalSince1970)
            timeModel.actualStartTime = srartTimerForLogIn
            RealmManager.shared.saveModel(model: timeModel)
            print (Realm.Configuration.defaultConfiguration.fileURL)
        }
        
        startTimer = Int(Date().timeIntervalSince1970)
        timer.invalidate()
         
         changeTimeButton.isHidden = true

        timer = Timer.scheduledTimer(withTimeInterval: 0.01,
                                     repeats: true,
                                     block: { [weak self] timers in
            guard let self = self else { return }
            self.timerProgress += 0.01
            
            currentTime = Int(Date().timeIntervalSince1970)
            let actualProgress = currentTime - startTimer
            if timerProgress < Double(actualProgress)-1 {
                timerProgress = Double(actualProgress)+1
            }
            
//            print("break")
            if self.timerProgress > self.breakTimeDuration {
                self.timerProgress = self.breakTimeDuration
                timers.invalidate()
                self.stopTimer(mission: false)
                completion(self.timerProgress)
                restartgo = false
            }


            self.configure(withWorkeTime: self.breakTimeDuration, or: false, progress: self.timerProgress)
        })
         
    }

   func pauseTimer() {
       timer.invalidate()
   }

    func stopTimer(mission: Bool) {
        
       guard self.timerProgress > 0 else { return }
       timer.invalidate()
               
       timer = Timer.scheduledTimer(withTimeInterval: 0.01,
                                    repeats: true,
                                    block: { [weak self] timer in
           guard let self = self else { return }
           self.timerProgress -= (mission ? self.workingTimerDuration : self.breakTimeDuration) * 0.02

           if self.timerProgress <= 0 {
               self.timerProgress = 0
               timer.invalidate()
           }

           self.configure(withWorkeTime: (mission ? self.workingTimerDuration : self.breakTimeDuration), or: true, progress: self.timerProgress)
       })
   }
    
}

extension TimerView {
    override func setupViews() {
        super.setupViews()
        
        setupView(progressView)
        setupView(timeSackView)
        setupView(bottomStackView)
        [
            elapsedTimeLable,
            elapsedTimeValueLable,
            remainingTimeLable,
            remainingTimeValueLable,
            changeTimeButton
        ].forEach (timeSackView.addArrangedSubview)
        [
            completedPersentView,
            bottomSeparator,
            remeiningPercentView
        ].forEach (bottomStackView.addArrangedSubview)
        
    }
    override func constaintViews() {
        super.constaintViews()
        
        NSLayoutConstraint.activate([
                        
            progressView.topAnchor.constraint(equalTo: topAnchor,constant: 40),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 20),
            
            timeSackView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: -20),
            timeSackView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 35),
            bottomStackView.widthAnchor.constraint(equalToConstant: 180),
            
            bottomSeparator.widthAnchor.constraint(equalToConstant: 1),
            bottomSeparator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
            
    }
   
}

private extension TimerView {
    func getDisplayedString(from value: Int) -> String {
        let seconds = value % 60
        let minutes = (value / 60) % 60
        let hours = value / 3600
        
        let secondStr = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minutesStr = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let hoursStr = hours < 10 ? "0\(hours)" : "\(hours)"
        
        return hours != 0
        ? [hoursStr, minutesStr, secondStr].joined(separator: ":")
        : [minutesStr, secondStr].joined(separator: ":")
        
    }
}
