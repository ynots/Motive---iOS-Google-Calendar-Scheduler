//
//  AppDelegate.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-03-28.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import GoogleAPIClient
import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate {

    private let kKeychainItemName = "No Excuses"
    private let kClientID = "812989291150-9ikloce8f7c599v2fom2dffh4fqe1gkh.apps.googleusercontent.com"
    
    private let kGTLAuthScopeGCalReadWrite = "https://www.googleapis.com/auth/calendar"
    private let kGTLAuthScopeGCalReadOnly = "https://www.googleapis.com/auth/calendar.readonly"
    
    private let service = GTLServiceCalendar()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        // Set up GoogleSignIn
        GIDSignIn.sharedInstance().clientID = kClientID
        GIDSignIn.sharedInstance().scopes.append(kGTLAuthScopeGCalReadWrite)
        GIDSignIn.sharedInstance().scopes.append(kGTLAuthScopeGCalReadOnly)
        GIDSignIn.sharedInstance().delegate = self
        
        // Set up Remote notifications
//        registerForRemoteNotification()
        return true
    }

    /*
     * Google SignIn Functions
     */
    func application(_ application: UIApplication,
                     open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            print("Wow! Our user signed in! \(user!)")
            if let currentUser = GIDSignIn.sharedInstance().currentUser {
                UserDefaults.standard.setValue(currentUser.profile.givenName!, forKey: "givenName")
                UserDefaults.standard.setValue(currentUser.profile.familyName!, forKey: "familyName")
                
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                
                var vc: UIViewController
                if (UserDefaults.standard.value(forKey: "fromTime") == nil
                    || UserDefaults.standard.value(forKey: "toTime") == nil
                    || UserDefaults.standard.value(forKey: "repetitions") == nil ) {
                    vc =  mainStoryBoard.instantiateViewController(withIdentifier: "setupTimeView") as! SetupTimeVC
                } else {
                    vc =  mainStoryBoard.instantiateViewController(withIdentifier: "userInterfaceView") as! UserInterfaceVC
                }
                UIView.transition(from: (self.window?.rootViewController!.view)!, to: vc.view, duration: 0.6, options: [.transitionCrossDissolve], completion: {
                    _ in
                    self.window?.rootViewController = vc
                })
            }
        } else {
            print("Looks like we got an sign-in error: \(error)")
        }
    }
    
    /*
     * Push Notification Handler
     */
//    func registerForRemoteNotification() {
//        if #available(iOS 10.0, *) {
//            let center  = UNUserNotificationCenter.current()
//            center.delegate = self
//            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
//                if error == nil{
//                    UIApplication.shared.registerForRemoteNotifications()
//                }
//            }
//        }
//        else {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//    
//    //Called when a notification is delivered to a foreground app.
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("User Info = ",notification.request.content.userInfo)
//        completionHandler([.alert, .badge, .sound])
//    }
//    
//    //Called to let your app know which action was selected by the user for a given notification.
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("User Info = ",response.notification.request.content.userInfo)
//        completionHandler()
//    }
//    
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "No_Excuses")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

