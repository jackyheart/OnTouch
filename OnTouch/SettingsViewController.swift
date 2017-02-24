//
//  SettingsViewController.swift
//  OnTouch
//
//  Created by Jacky on 24/2/17.
//  Copyright © 2017 Jacky. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak private var forceLbl: UILabel!
    @IBOutlet weak private var square: UIView!
    private var maxHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "3D Touch Demo"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let screen = UIScreen.main.bounds
        let squareWidth = self.square.bounds.width
        
        var squareFrame = self.square.frame
        squareFrame.origin = CGPoint(x: screen.width - squareWidth, y: screen.height - squareWidth - (self.tabBarController?.tabBar.frame.size.height)! - 64)
        self.square.frame = squareFrame
        
        self.maxHeight = squareFrame.origin.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    //3d Touch available
                    
                    let force = touch.force / touch.maximumPossibleForce
                    self.forceLbl.text = "\(force)% force"
                    
                    let percent = 1.0 - force
                    let yPercent = (percent * self.maxHeight)
                    
                    var squareFrame = self.square.frame
                    squareFrame.origin.y = yPercent
                    self.square.frame = squareFrame
                }
                else {
                    
                    //3d Touch Not available
                    let alert = UIAlertController(title: "Not Available", message: "3D Touch is not available on this device.", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.forceLbl.text = "0% force"
        
        var squareFrame = self.square.frame
        squareFrame.origin.y = self.maxHeight
        self.square.frame = squareFrame
    }
}
