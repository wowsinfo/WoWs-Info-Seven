//
//  ViewController.swift
//  wowsinfo
//
//  Created by Yiheng Quan on 14/7/21.
//

import UIKit
import React

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onReactNativeButtonTapped(_ sender: UIButton) {
        // Push to a view controller with a react native view inside
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "WoWsInfo",
            initialProperties: nil,
            launchOptions: nil
        )

        let vc = UIViewController()
        vc.view = rootView
        self.present(vc, animated: true, completion: nil)
    }
}
