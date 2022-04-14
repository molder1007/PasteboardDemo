//
//  CopyImageView.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

class CopyImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                          action: #selector(showMenu(_:))))
    }
    
    @objc func showMenu(_ sender: UILongPressGestureRecognizer) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.showMenu(from: self, rect: bounds)
        }
    }
    
    override func copy(_ sender: Any?) {
        let tmpImage = self.image?.imageWithNewSize(size: CGSize(width: 1920, height: 1080))
        guard let data = tmpImage?.compressImageMid(maxLength: 1920 * 1080), let newImage = UIImage(data: data) else { return }
        UIPasteboard.general.image = newImage
        UIMenuController.shared.hideMenu()
    }
    
    override func paste(_ sender: Any?)  {
        self.image = UIPasteboard.general.image
        UIMenuController.shared.hideMenu()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?)
    -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) && self.image != nil {
            return true
        } else if action == #selector(UIResponderStandardEditActions.paste(_:)) && self.image == nil {
            return true
        }
        return false
    }
}
