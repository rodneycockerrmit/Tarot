//
//  AppDelegate.swift
//  Tarot
//
//  Created by Rodney Cocker on 3/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /* Get references to all of our controllers so we can set the intial data */
        let tabBarController = self.window!.rootViewController as! UITabBarController
        
        /* This is the controller on the second tab, so we use the index of 1 */
        let splitViewController = tabBarController.viewControllers![1] as! UISplitViewController
        
        /* The split view controller has two navigation controllers, the first one is for the Master View, the second one is for the Detail View */
        let navControllerForMasterView = splitViewController.viewControllers.first as! UINavigationController
        let navControllerFordetailViewController = splitViewController.viewControllers.last as! UINavigationController
        
        /* The table view controller is the first or top controller of the nav controller for the master view */
        let masterViewController = navControllerForMasterView.topViewController as! TarotTableViewController
        
        /* The detail view controller is the first or top controller of the nav controller for detail view */
        let detailViewController = navControllerFordetailViewController.topViewController as! TarotCardDetailViewController
        
        /* Grab a default card from the model */
        let defaultCard = Model.sharedInstance.currentCard
        
        /* Set this as the default card to display in both the table view and detail view */
        masterViewController.currentCard = defaultCard
        detailViewController.card = defaultCard
        /* Set the delegate in the table view to point to the detail view */
        masterViewController.delegate = detailViewController
        
        detailViewController.navigationItem .leftItemsSupplementBackButton = true
        detailViewController.navigationItem .leftBarButtonItem = splitViewController.displayModeButtonItem
        return true
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


}

