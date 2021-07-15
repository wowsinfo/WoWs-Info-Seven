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
        view = RNHandler.shared.getRNView(with: "WoWsInfo")
    }
}
