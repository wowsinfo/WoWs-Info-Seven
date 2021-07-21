//
//  QuickActionManager.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 19/7/21.
//

import UIKit

private enum QuickActionType: String {
    case search
    case warships
    case account
}

/// A good discussion https://stackoverflow.com/questions/31870775/react-native-sending-events-to-javascript-in-swift
@objc(QuickActionManager)
class QuickActionManager: NSObject {
    
    // Singleton
    static let shared = QuickActionManager()
    private override init() {
        super.init()
    }
    
    /// NOTE: RCTEventEmitter is created by React Native so shouldn't subclass it
    /// It will be injected with it is created by React Native
    private var emitter: QuickActionEventEmitter?
    
    private var pendingShortcut: String?

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
    
    func injectEventEmitter(_ emitter: QuickActionEventEmitter) {
        self.emitter = emitter
    }
    
    func performShortcut(shortcutItem: UIApplicationShortcutItem) {
        let type = shortcutItem.type
        // App is loaded
        if ReactNativeManager.shared.isLoaded, let emitter = emitter {
            emitter.sendEvent(with: type)
        } else {
            // The user started the app by using 3D Touch, add this to pending
            pendingShortcut = type
        }
    }
    
    // Search & Warships
    func setDefaultActions() {
        UIApplication.shared.shortcutItems = defaultActions
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
    
    @objc func performPendingShortcut() {
        // Perform pending shortcut once it is initialised
        if let shortcut = pendingShortcut {
            emitter?.sendEvent(with: shortcut)
            pendingShortcut = nil
        }
    }
}
