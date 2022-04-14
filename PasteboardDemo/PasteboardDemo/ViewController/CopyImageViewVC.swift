//
//  CopyImageViewVC.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

class CopyImageViewVC: UIViewController {
    @IBOutlet weak var pasteImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Copy ImageView"
        pasteImageView.layer.borderColor = UIColor.gray.cgColor
        pasteImageView.layer.borderWidth = 1
    }

    @IBAction func clearButton(_ sender: UIButton) {
        if pasteImageView.image != nil {
            pasteImageView.image = nil
        }
    }
}
