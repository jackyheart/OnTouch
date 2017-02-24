//
//  NewMessageViewController.swift
//  OnTouch
//
//  Created by Jacky on 24/2/17.
//  Copyright © 2017 Jacky. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
