//
//  ListDetailViewController.swift
//  OnTouch
//
//  Created by Jacky on 24/2/17.
//  Copyright © 2017 Jacky. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController {

    var contact = ""
    var contactIndex = -1
    @IBOutlet weak private var messageLBl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.messageLBl.text = "Chat with \(self.contact)"
        self.navigationItem.title = self.contact
        
        if contactIndex > -1 {
            self.imageView.image = UIImage(named: "\(contactIndex)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
    
        let heart = UIPreviewAction(title: "Like", style: .default) { (action, viewController) in
            
            //send a heart
        }
        
        let save = UIPreviewAction(title: "Save Chat", style: .default) { (action, viewController) in
            
            //save action
        }
        
        let delete = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) in
            
            //delete action
        }
        
        return [heart, save, delete]
    }
}
