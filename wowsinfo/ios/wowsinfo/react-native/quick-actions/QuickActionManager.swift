//
//  QuickActionManager.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 19/7/21.
//

import UIKit
import React

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
        sendEvent(withName: type, body: ["type": type])
    }
    
    // Search & Warships
    func setDefaultActions() {
        UIApplication.shared.shortcutItems = defaultActions
    }
    
    // MARK: - RCTEventEmitter
    
    var hasListener = false

    override func startObserving() {
        hasListener = true
    }

    override func stopObserving() {
        hasListener = false
    }
    
    // Add main account with username
    @objc func addMainAccount(username: String) {
        UIApplication.shared.shortcutItems = defaultActions + [
            UIApplicationShortcutItem(
                type: QuickActionType.account.rawValue, localizedTitle: username,
                localizedSubtitle: nil,
                icon: .init(type: .favorite), userInfo: nil)
        ]
    }
    
    
    override func supportedEvents() -> [String]! {
        RNEvents.allCases.map { $0.rawValue }
    }
}
