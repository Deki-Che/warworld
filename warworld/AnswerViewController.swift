//
//  AnswerViewController.swift
//  warworld
//
//  Created by ldci on 14/6/24.
//  Copyright (c) 2014年 郑赟. All rights reserved.
//

import Foundation
import UIKit

class AnswerViewController: UIViewController {
    
    var currentLevel = 0
    var currentQuestion = 0;
    let allQuestions = [
        ["什么鱼不能吃？", "A 鳄鱼", "B 鲨鱼", "C 木鱼", "D 飞鱼"],
        ["什么东西越洗越脏？", "A 抹布", "B 衣服", "C 白菜", "D 大狗"],
        ["鸟不会得什么病？", "A 痔疮", "B 恐高症", "C 感冒", "D 发烧"],
        ["你孤单时会想谁？", "A 汽水", "B 老师", "C 小伙伴", "D 宠物"]]
    let rightAnswer = [3, 1, 2, 1]
    
    var buttonA = UIButton()
    var buttonB = UIButton()
    var buttonC = UIButton()
    var buttonD = UIButton()
    var buttonALabel = UILabel()
    var buttonBLabel = UILabel()
    var buttonCLabel = UILabel()
    var buttonDLabel = UILabel()
    var questionLabel = UILabel()
    
    var questionUpdateTimer:NSTimer?
    var countDownTimer:NSTimer?
    var timeNum = 20
    var timeLabel = UILabel()
    var totalNum = 4
    var rightNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("AnswerViewController->viewDidLoad")
        
        
        let backImageview = UIImageView()
        backImageview.frame = CGRectMake(0,0,480,320)
        let image = UIImage(named:"对战背景05@2x.png")
        backImageview.image = image
        self.view.addSubview(backImageview)
        
        let backButton = UIButton()
        backButton.frame = CGRectMake(5,140,50,50)
        backButton.setImage(UIImage(named:"left_arrow.png"),forState:.Normal)
        self.view.addSubview(backButton)
        backButton.addTarget(self, action:"turnBack",forControlEvents:.TouchUpInside)
        
        questionLabel.frame = CGRectMake(80,100,320,80)
        questionLabel.text = allQuestions[0][0]
        questionLabel.textAlignment = .Center
        self.view.addSubview(questionLabel)
        
        buttonA.frame = CGRectMake(30,210,220,40)
        buttonA.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        self.view.addSubview(buttonA)
        buttonA.addTarget(self, action:"judgeResult:",forControlEvents:.TouchUpInside)
        buttonA.tag = 1
        
        buttonALabel.frame = CGRectMake(30,210,220,40)
        buttonALabel.text = allQuestions[0][1]
        buttonALabel.textColor = UIColor.whiteColor()
        buttonALabel.textAlignment = .Center
        self.view.addSubview(buttonALabel)
        
        buttonB.frame = CGRectMake(230,210,220,40)
        buttonB.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        self.view.addSubview(buttonB)
        buttonB.tag = 2
        buttonB.addTarget(self, action:"judgeResult:",forControlEvents:.TouchUpInside)
        
        buttonBLabel.frame = CGRectMake(230,210,220,40)
        buttonBLabel.text = allQuestions[0][2]
        buttonBLabel.textColor = UIColor.whiteColor()
        buttonBLabel.textAlignment = .Center
        self.view.addSubview(buttonBLabel)
        
        buttonC.frame = CGRectMake(30,260,220,40)
        buttonC.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        self.view.addSubview(buttonC)
        buttonC.tag = 3
        buttonC.addTarget(self, action:"judgeResult:",forControlEvents:.TouchUpInside)
        
        buttonCLabel.frame = CGRectMake(30,260,220,40)
        buttonCLabel.text = allQuestions[0][3]
        buttonCLabel.textColor = UIColor.whiteColor()
        buttonCLabel.textAlignment = .Center
        self.view.addSubview(buttonCLabel)
        
        buttonD.frame = CGRectMake(230,260,220,40)
        buttonD.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        buttonD.tag = 4
        self.view.addSubview(buttonD)
        buttonD.addTarget(self, action:"judgeResult:",forControlEvents:.TouchUpInside)
        
        buttonDLabel.frame = CGRectMake(230,260,220,40)
        buttonDLabel.text = allQuestions[0][4]
        buttonDLabel.textColor = UIColor.whiteColor()
        buttonDLabel.textAlignment = .Center
        self.view.addSubview(buttonDLabel)
        
        
        timeLabel.frame = CGRectMake(50,30,80,30)
        timeLabel.text = "00:\(timeNum)"
        timeLabel.backgroundColor = UIColor.blueColor()
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.textAlignment = .Center
        self.view.addSubview(timeLabel)
    }
    
    func setOriginState() {
        timeNum = 20
        currentQuestion = 0
        rightNum = 0
        buttonA.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        buttonB.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        buttonC.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        buttonD.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
        
        buttonA.enabled = true
        buttonB.enabled = true
        buttonC.enabled = true
        buttonD.enabled = true
        
        questionLabel.text = allQuestions[currentQuestion][0]
        buttonALabel.text = allQuestions[currentQuestion][1]
        buttonBLabel.text = allQuestions[currentQuestion][2]
        buttonCLabel.text = allQuestions[currentQuestion][3]
        buttonDLabel.text = allQuestions[currentQuestion][4]
        
    }
    func updateTimer() {
        timeNum--;
        if timeNum <= 0 {
            countDownTimer?.invalidate()
            timeNum = 20
            //弹出一个警告框：UIAlertView
            let alert = UIAlertController(title: "提示", message: "亲，时间已到！", preferredStyle: .Alert)
            let actionYes = UIAlertAction(title: "重做", style: .Default, handler: {act in
                self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"updateTimer", userInfo: nil, repeats: true)
                })
            let actionNo = UIAlertAction(title: "不重做", style: .Default, handler: {act in
                let rvc = ResultViewController()
                rvc.totalNum = self.totalNum
                rvc.rightNum = self.rightNum
                rvc.wrongNum = self.totalNum - self.rightNum
                rvc.timeNum = 20
                if self.rightNum > self.totalNum/2 {
                    allLevels[self.currentLevel] = 1
                    writeAllLevels()
                }
                self.presentViewController(rvc, animated: true, completion: nil)
                })
            alert.addAction(actionYes)
            alert.addAction(actionNo)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        if timeNum < 10 {
            timeLabel.text = "00:0\(timeNum)"
        }
        else {
            timeLabel.text = "00:\(timeNum)"
        }
        
    }
    
    func judgeResult(sender:UIButton){
        if sender.tag == rightAnswer[currentQuestion] {
            sender.setImage(UIImage(named:"答对@2x.png"),forState:.Normal)
            rightNum++
        }
        else {
            sender.setImage(UIImage(named:"答错@2x.png"),forState:.Normal)
        }
        buttonA.enabled = false
        buttonB.enabled = false
        buttonC.enabled = false
        buttonD.enabled = false
        
        //过1秒钟，你去更新题目和选项
        //performSelector()
        questionUpdateTimer?.invalidate()
        questionUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"updateQuestion", userInfo: sender, repeats: false)
    }
    
    func updateQuestion() {
        currentQuestion++
        if currentQuestion >= 4 {
            //跳到结果界面
            var rvc = ResultViewController()
            rvc.totalNum = self.totalNum
            rvc.rightNum = self.rightNum
            rvc.wrongNum = self.totalNum - self.rightNum
            rvc.timeNum = 20 - self.timeNum
            if self.rightNum > self.totalNum/2 {
                allLevels[currentLevel] = 1
                writeAllLevels()
            }
            self.presentViewController(rvc, animated: true, completion: nil)
            return
        }
        
        buttonA.enabled = true
        buttonB.enabled = true
        buttonC.enabled = true
        buttonD.enabled = true
        
        questionLabel.text = allQuestions[currentQuestion][0]
        buttonALabel.text = allQuestions[currentQuestion][1]
        buttonBLabel.text = allQuestions[currentQuestion][2]
        buttonCLabel.text = allQuestions[currentQuestion][3]
        buttonDLabel.text = allQuestions[currentQuestion][4]
        
        var sender = questionUpdateTimer?.userInfo as! UIButton
        sender.setImage(UIImage(named:"平时状态@2x.png"),forState:.Normal)
    }
    
    
    func turnBack() {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        print("AnswerViewController->viewWillAppear")
        countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"updateTimer", userInfo: nil, repeats: true)
        setOriginState()
    }
    
    override func viewDidAppear(animated: Bool){
        print("AnswerViewController->viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool){
        print("AnswerViewController->viewWillDisappear")
        countDownTimer?.invalidate()
    }
    
    override func viewDidDisappear(animated: Bool){
        print("AnswerViewController->viewDidDisappear")
    }
    
}
