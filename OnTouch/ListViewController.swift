//
//  ListViewController.swift
//  OnTouch
//
//  Created by Jacky on 24/2/17.
//  Copyright © 2017 Jacky. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    var dataArray = ["Louis Lane", "Mary Jane Watson", "Pepper Potts", "Gwen Stacy", "Jean Grey", "Scarlet Witch", "Wonder Woman", "Catwoman", "Elektra", "Jessica Jones", "Black Widow", "Black Canary", "Captain Marvel", "Harley Quinn"]
    
    var frequentArrayIndex = [0,1,2]//default contacts for quick actions
    var imageArrayIndex = [4,6,13]//array on which index has image
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "3D Touch Demo"
        
        //default Quick actions entry
        self.populateQuickActions()
        
        //register for previewing
        self.registerForPreviewing(with: self, sourceView: self.tblView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helper
    
    func populateQuickActions() {
        
        var shortcutItems:[UIApplicationShortcutItem] = []
        
        let type = "\(Bundle.main.bundleIdentifier).SendChat"
        let subtitle = "Send a chat"
        
        let icon = UIApplicationShortcutIcon(templateImageName: "DefaultProfile")
        
        for contactIndex in self.frequentArrayIndex {
            let contactName = dataArray[contactIndex]
            let shortcutItem = UIApplicationShortcutItem(type: type, localizedTitle: contactName, localizedSubtitle: subtitle, icon: icon, userInfo: ["contactIndex":contactIndex])
            
            shortcutItems.append(shortcutItem)//add to shortcutItems array
        }
        
        UIApplication.shared.shortcutItems = shortcutItems
    }
    
    //MARK: - Quick Actions functions
    
    func composeNewMessage() {
        self.performSegue(withIdentifier: "segueNewMessage", sender: nil)
    }
    
    func chatWith(contactIndex:Int) {
        //self.tableRowSelectAction(withIndex: contactIndex)
        
        let indexPath = IndexPath(row: contactIndex, section: 0)
        self.tblView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "segueListDetail", sender: nil)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listIdentifier", for: indexPath)
        
        let title = self.dataArray[indexPath.row]
        let subtitle = "last message"
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
        
        return cell
    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //adjust Quick Actions
        let selectedIndex = indexPath.row
        if(!self.frequentArrayIndex.contains(selectedIndex)) {
            
            //if selected contact is not in the most-frequent list
            
            //remove last contact from most-frequent list
            let count = self.frequentArrayIndex.count
            self.frequentArrayIndex.remove(at: count-1)
            
            //insert to the the top-most index
            self.frequentArrayIndex.insert(selectedIndex, at: 0)
            
            //re-populate shortcut items
            self.populateQuickActions()
        }
    }
    
    //MARK: - UIViewControllerPreviewingDelegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.tblView.indexPathForRow(at: location) else { return nil }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        
        let contact = self.dataArray[indexPath.row]
        detailVC.contact = contact
        
        if(self.imageArrayIndex.contains(indexPath.row)) {
            //if character image is available
            detailVC.contactIndex = indexPath.row
        }
        
        let cellRect = self.tblView.rectForRow(at: indexPath)
        let sourceRect = previewingContext.sourceView.convert(cellRect, from: self.tblView)
        previewingContext.sourceRect = sourceRect
        
        return detailVC
    }

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueListDetail" {
            let destinationVC = segue.destination as! ListDetailViewController
            
            if let indexPath = self.tblView.indexPathForSelectedRow {
                
                self.tblView.deselectRow(at: indexPath, animated: true)
                
                let contact = self.dataArray[indexPath.row]
                destinationVC.contact = contact
                
                if(self.imageArrayIndex.contains(indexPath.row)) {
                    //if character image is available
                    destinationVC.contactIndex = indexPath.row
                }
            }
        }
    }
}
