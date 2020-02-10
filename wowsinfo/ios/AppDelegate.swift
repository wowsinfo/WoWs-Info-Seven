//
//  AppDelegate.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 10/2/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCTBridgeDelegate {
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    let url: URL!
    
    #if DEBUG
        print("DEBUG")
        url = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
    #else
        print("RELEASE")
        url = Bundle.main.url(forResource: "main", withExtension: "jsbundle")
    #endif
    
    print(url!)
    return url
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    let rootView = RCTRootView(bridge: bridge!, moduleName: "wowsinfo", initialProperties: nil)
    rootView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)

    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()

    return true
  }
}
