//
//  QuickActionEventEmitter.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 20/7/21.
//

import React

private enum RNEvents: String, CaseIterable {
    case quick_action
}

@objc(QuickActionEventEmitter)
class QuickActionEventEmitter: RCTEventEmitter {

    private var hasListener = false

    override init() {
        super.init()
        QuickActionManager.shared.injectEventEmitter(self)
    }

    override func startObserving() {
        super.startObserving()
        hasListener = true
    }

    override func stopObserving() {
        super.stopObserving()
        hasListener = false
    }

    override func supportedEvents() -> [String]! {
        RNEvents.allCases.map { $0.rawValue }
    }

    /// A wrapper for sendEvent(with name)
    func sendEvent(with type: String) {
        if hasListener {
            sendEvent(withName: RNEvents.quick_action.rawValue, body: type)
        }
    }
}
