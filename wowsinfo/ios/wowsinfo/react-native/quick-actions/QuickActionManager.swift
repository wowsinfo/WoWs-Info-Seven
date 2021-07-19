//
//  QuickActionManager.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 19/7/21.
//

import Foundation
import UIKit

private enum QuickActionType: String {
    case search
    case warships
    case account
}

private enum RNEvents: String, CaseIterable {
    case quick_action
}

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
        if let type = QuickActionType(rawValue: shortcutItem.type) {
            // Send this event to React Native
            quickActionEvent(type: type.rawValue)
        } else {
            assertionFailure("Unknown QuickActionType")
            success(false)
        }
    }
    
    func sendShortcutToRN(type: String, complete: RCTResponseSenderBlock) {}
    
    // Search & Warships
    func setDefaultActions() {
        UIApplication.shared.shortcutItems = defaultActions
    }
    
    // Add main account with username
    func addMainAccount(with username: String) {
        UIApplication.shared.shortcutItems = defaultActions + [
            UIApplicationShortcutItem(
                type: QuickActionType.account.rawValue, localizedTitle: username,
                localizedSubtitle: nil,
                icon: .init(type: .favorite), userInfo: nil)
        ]
    }
    
    // MARK: - RCTEventEmitter
    
    var hasListener = false

    override func startObserving() {
        hasListener = true
    }

    override func stopObserving() {
        hasListener = false
    }
    
    // Send quick action event from native to react native
    @objc func quickActionEvent(type: String) {
        if hasListener {
            sendEvent(withName: RNEvents.quick_action.rawValue, body: [type: type])
        }
    }
    
    override func supportedEvents() -> [String]! {
        RNEvents.allCases.map { $0.rawValue }
    }
}
