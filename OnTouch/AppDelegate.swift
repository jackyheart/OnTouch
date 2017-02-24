//
//  AppDelegate.swift
//  OnTouch
//
//  Created by Jacky on 24/2/17.
//  Copyright © 2017 Jacky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var isLaunchedFromQuickAction = false
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
        
            print("Application first launched from Quick action !")
            
            isLaunchedFromQuickAction = true
            handleQuickAction(shortcutItem: shortcutItem)
            
        } else {
            self.window?.backgroundColor = UIColor.white
        }
        
        // Return false if the app was launched from a shortcut, so performAction... will not be called.
        return !isLaunchedFromQuickAction
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    //3d touch
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        //handle quick action
        completionHandler(handleQuickAction(shortcutItem: shortcutItem))
    }
    
    enum Shortcut:String {
        case newMessage = "NewMessage"
        case sendChat = "SendChat"
    }
    
    func handleQuickAction(shortcutItem:UIApplicationShortcutItem) -> Bool {
    
        var quickActionHandled = false
        
        let type = shortcutItem.type.components(separatedBy: ".").last!
        if let shortcutType = Shortcut.init(rawValue: type) {
            
            switch shortcutType {
                
                case .newMessage:
                    print("new message action")
                    if let tabController = self.window?.rootViewController as? UITabBarController {
                        if let navigationController = tabController.viewControllers?.first as? UINavigationController {
                            for viewController in navigationController.viewControllers {
                                if viewController is ListViewController {
                                    (viewController as! ListViewController).composeNewMessage()
                                    break
                                }
                            }
                        }
                    }
                    quickActionHandled = true
                    break
                
                case .sendChat:
                    
                    if let tabController = self.window?.rootViewController as? UITabBarController {
                        if let navigationController = tabController.viewControllers?.first as? UINavigationController {
                            
                            if navigationController.viewControllers.count > 1 {
                                navigationController.popToRootViewController(animated: true)
                            }
                            
                            for viewController in navigationController.viewControllers {
                                if viewController is ListViewController {
                                    let contactIndex = shortcutItem.userInfo?["contactIndex"] as! Int
                                    (viewController as! ListViewController).chatWith(contactIndex: contactIndex)
                                    
                                    print("send chat action to contactIndex: \(contactIndex)")
                                    break
                                }
                            }
                        }
                    }
                    quickActionHandled = true
                    break
            }
        }
        
        return quickActionHandled
    }
}

