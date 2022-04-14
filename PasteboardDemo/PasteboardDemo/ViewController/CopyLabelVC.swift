//
//  CopyLabelVC.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

class CopyLabelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Copy Label"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
