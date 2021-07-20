//
//  QuickActionManager.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 19/7/21.
//

import React
import UIKit

private enum QuickActionType: String {
    case search
    case warships
    case account
}

private enum RNEvents: String, CaseIterable {
    case quick_action
}

/// A good discussion https://stackoverflow.com/questions/31870775/react-native-sending-events-to-javascript-in-swift
@objc(QuickActionManager)
class QuickActionManager: RCTEventEmitter {
    
    // Singleton
    static let shared = QuickActionManager()
    override private init() {
        super.init()
        /// NOTE: bridge must be set here
        self.bridge = ReactNativeManager.shared.bridge
    }
    
    private let defaultActions = [
        UIApplicationShortcutItem(
            type: QuickActionType.search.rawValue, localizedTitle: "Search",
            localizedSubtitle: nil,
            icon: .init(type: .search), userInfo: nil),
        UIApplicationShortcutItem(
            type: QuickActionType.warships.rawValue, localizedTitle: "Warships",
            localizedSubtitle: nil,
            icon: .init(type: .bookmark), userInfo: nil)
    ]
    
    func performShortcut(shortcutItem: UIApplicationShortcutItem, success: @escaping (Bool) -> Void) {
        let type = shortcutItem.type
        // Send event to react native
        if hasListener {
            sendEvent(withName: RNEvents.quick_action.rawValue, body: ["type": type])
            success(true)
        } else {
            success(false)
        }
    }
    
    // Search & Warships
    func setDefaultActions() {
        UIApplication.shared.shortcutItems = defaultActions
    }
    
    // MARK: - RCTEventEmitter
    
    private var hasListener = false

    override func startObserving() {
        super.startObserving()
        hasListener = true
    }

    override func stopObserving() {
        super.stopObserving()
        hasListener = false
    }
    
    /// Add main account with username
    /// Note: it needs to be (_ username: String) here so that JS can call it properly
    @objc func addMainAccount(_ username: String) {
        DispatchQueue.main.async {
            UIApplication.shared.shortcutItems = self.defaultActions + [
                UIApplicationShortcutItem(
                    type: QuickActionType.account.rawValue, localizedTitle: username,
                    localizedSubtitle: nil,
                    icon: .init(type: .favorite), userInfo: nil)
            ]
        }
    }
    
    override func supportedEvents() -> [String]! {
        RNEvents.allCases.map { $0.rawValue }
    }
}
