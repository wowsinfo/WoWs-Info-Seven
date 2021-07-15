//
//  RNHandler.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 15/7/21.
//

import Foundation
import React

typealias RNDict = [NSObject: Any]

class RNHandler: NSObject, RCTBridgeDelegate {
    
    // Singleton
    static let shared = RNHandler()
    private override init() {}
    
    /// Setup the bridge so only one JSC VM is created to save resources and simplify the communication between RN views in different parts of your native app,
    /// you can have multiple views powered by React Native that are associated with a single JS runtime.
    private var bridge: RCTBridge!
    
    func setup(with launchOptions: [AnyHashable: Any]?) {
        bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    }
    
    private(set) lazy var jsBundleURL: URL = {
        sourceURL(for: bridge)
    }()
    
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        #if DEBUG
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
        #else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
    
    /// The wrapper of RCTRootView
    func getRNView(with name: String, and props: RNDict? = nil) -> RCTRootView {
        RCTRootView(bridge: bridge, moduleName: name, initialProperties: props)
    }
    
    /// Get a RCTRootView and wrap it in a view controller
    func getRNViewController(with name: String, and props: RNDict? = nil) -> UIViewController {
        let vc = UIViewController()
        vc.view = getRNView(with: name, and: props)
        return vc
    }
}
