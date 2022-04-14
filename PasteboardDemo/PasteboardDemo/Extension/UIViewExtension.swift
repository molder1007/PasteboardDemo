//
//  UIViewExtension.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/13.
//

import UIKit

extension UIView {
    func showToast(text: String) {
        let toastLb = ToastLabel().initToastLabel(text: text, view: self)
        addSubview(toastLb)

        UIView.animate(withDuration: 1, delay: 1, animations: {
            toastLb.alpha = 0.0
        }) { _ in
            toastLb.removeFromSuperview()
        }
    }
}
