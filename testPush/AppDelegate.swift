//
//  AppDelegate.swift
//  testPush
//
//  Created by Vladimir Psyukalov on 4/28/21.
//

import Cocoa
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            guard let self = self else {
                return
            }
            if granted && error == nil {
                print("-->> granted")
                DispatchQueue.main.async {
                    NSApp.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
                }
            } else {
                print("-->> error: \(String(describing: error))")
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("-->> token: \(deviceToken)")
    }
    
    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("-->> didFail: \(error)")
    }
}
