//
//  ViewController.swift
//  warworld
//
//  Created by ldci on 14/6/24.
//  Copyright (c) 2014年 郑赟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lightImageview : UIImageView? = nil
    var timer:NSTimer?
    var lightNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:"changeLight", userInfo: nil, repeats: true)
    }

    func changeLight() {
        lightNum++
        if lightNum > 12 {
            lightNum = 1
        }
        let image = UIImage(named:"\(lightNum).png")
        lightImageview!.image = image
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

