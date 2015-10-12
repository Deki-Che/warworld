//
//  ResultViewController.swift
//  warworld
//
//  Created by ldci on 14/6/26.
//  Copyright (c) 2014年 郑赟. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    var timeNum = 0
    var totalNum = 0
    var rightNum = 0
    var wrongNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("ResultViewController->viewDidLoad")
        
        let backImageview = UIImageView()
        backImageview.frame = CGRectMake(0,0,480,320)
        let image = UIImage(named:"战报背景@2x.png")
        backImageview.image = image
        self.view.addSubview(backImageview)
        
        let timeLabel = UILabel()
        timeLabel.frame = CGRectMake(100,100,320,40)
        timeLabel.text = "答题用时：\(timeNum)"
        timeLabel.textColor = UIColor.redColor()
        self.view.addSubview(timeLabel)
        
        let totalLabel = UILabel()
        totalLabel.frame = CGRectMake(100,140,320,40)
        totalLabel.text = "答题总数：\(totalNum)"
        totalLabel.textColor = UIColor.redColor()
        self.view.addSubview(totalLabel)
        
        let rightLabel = UILabel()
        rightLabel.frame = CGRectMake(100,180,320,40)
        rightLabel.text = "答对题数：\(rightNum)"
        rightLabel.textColor = UIColor.redColor()
        self.view.addSubview(rightLabel)
        
        let wrongLabel = UILabel()
        wrongLabel.frame = CGRectMake(100,220,320,40)
        wrongLabel.text = "答错题数：\(wrongNum)"
        wrongLabel.textColor = UIColor.redColor()
        self.view.addSubview(wrongLabel)
        
        let backButton = UIButton()
        backButton.frame = CGRectMake(5,140,50,50)
        backButton.setImage(UIImage(named:"left_arrow.png"),forState:.Normal)
        self.view.addSubview(backButton)
        backButton.addTarget(self, action:"turnBack",forControlEvents:.TouchUpInside)
        
        let nextButton = UIButton()
        nextButton.frame = CGRectMake(400,140,50,50)
        nextButton.setImage(UIImage(named:"right_arrow.png"),forState:.Normal)
        self.view.addSubview(nextButton)
        nextButton.addTarget(self, action:"turnNextLevel",forControlEvents:.TouchUpInside)
    }
    
    func turnNextLevel() {
        var sb = UIStoryboard(name: "Main", bundle:nil)
        var vc = sb.instantiateViewControllerWithIdentifier("ChooseViewController") as! ChooseViewController
        self.presentViewController(vc, animated:true, completion:nil)
    }
    func turnBack() {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool){
        print("ResultViewController->viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool){
        print("ResultViewController->viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool){
        print("ResultViewController->viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool){
        print("ResultViewController->viewDidDisappear")
    }
}
