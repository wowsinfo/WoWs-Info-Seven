//
//  RootViewController.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 14/7/21.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ReactNativeManager.shared.attach(rootViewController: self)
        view = ReactNativeManager.shared.getRNView(with: "WoWsInfo")
    }
}
