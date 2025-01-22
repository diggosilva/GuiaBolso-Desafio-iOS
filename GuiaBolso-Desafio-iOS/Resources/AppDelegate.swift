//
//  AppDelegate.swift
//  GuiaBolso-Desafio-iOS
//
//  Created by Diggo Silva on 22/01/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let initialViewController = MainScreenViewController()
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Handle app going to inactive state
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle app entering background
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle app coming to foreground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Handle app becoming active
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Handle app termination
    }
}
