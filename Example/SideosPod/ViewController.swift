//
//  ViewController.swift
//  SideosPod
//
//  Created by Your Name on 12/02/2022.
//  Copyright (c) 2022 Your Name. All rights reserved.
//

import UIKit
import SideosPod

class ViewController: UIViewController {

    override func viewDidAppear(_: Bool) {
        SideosSdk().startKYC(authToken: "", view: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

