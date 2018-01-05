//
//  AppDelegate.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2017/12/19.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        makeWindow()
        return true
    }
    
    fileprivate func makeWindow() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let versionCache = UserDefaults.standard.object(forKey: "VersionCache") as? String
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        if versionCache == version {
            let vc = MainViewController()
            let navVC = BaseNavigationController.init(rootViewController: vc)
            // 抽屉初始化，但是目前会跟nav冲突，待解决。
//            let vc =  DrawerViewController.drawerWithOpenViewController(leftVC: LeftViewController.init(), mainVC: MainViewController.init(), drawerMaxWidth: 100)
            window?.rootViewController = navVC
        } else {
            let vc = MovieViewController()
            if let path = Bundle.main.path(forResource: "qidong.mp4", ofType: nil){
                vc.movieUrl = URL.init(fileURLWithPath: path)
            }
            window?.rootViewController = vc
            // 初次开启项目记录版本号 如想每次都有启动动画 请注释
//            UserDefaults.standard.set(version, forKey: "VersionCache")
        }
        self.window?.makeKeyAndVisible()
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

