//
//  ViewController.swift
//  UiNavControllerExample
//
//  Created by Евгений Егоров on 17.02.2021.
//

import UIKit
import WebstoryzSDK
import SwiftUI

class ExampleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let child = SDK.thumbsVC(key: "LDLGjIR8GzycQCt14yC1SyPGUGuAvrRQtQm9io58dnYOcGRAmo0hO5vVRIizk3Oeu62aktawVDl8r8kMyJT2mkqPjyvUdirLAAoCnKDD0NVQpEt3PfhfH5YFujExi5oh", uiController: self)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 196)
        child.didMove(toParent: self)
        view.addSubview(child.view)
        addChild(child)
    }
}

