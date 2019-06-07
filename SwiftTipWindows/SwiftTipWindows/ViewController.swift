//
//  ViewController.swift
//  SwiftTipWindows
//
//  Created by ch4r0n on 2019/6/4.
//  Copyright © 2019 ch4r0n. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var message : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.message = "hello world"
        // Do any additional setup after loading the view.
    }
    
    func getATestMessage() -> String {
        return "helloworld"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func showMessage(_ sender: Any) {
        let alert = NSAlert()
        alert.addButton(withTitle: "OK!")
        alert.addButton(withTitle: "Cancel")
        alert.messageText = getATestMessage()
        alert.alertStyle = .warning
        alert.runModal()
        
    }
    

}

