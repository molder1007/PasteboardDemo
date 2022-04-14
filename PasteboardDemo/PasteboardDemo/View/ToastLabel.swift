//
//  ToastLabel.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/13.
//

import UIKit

class ToastLabel: UILabel {
    func initToastLabel(text: String, view: UIView) -> UILabel {
        hideToast(views: view)

        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999 // tag：hideToast實用來判斷要remove哪個label

        let maxSize = CGSize(width: view.bounds.width - 40, height: view.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width {
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height {
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((view.bounds.size.width) / 2) - ((expectedSize.width + 20) / 2), y: view.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        return toastLb
    }

    private func hideToast(views: UIView) {
        for view in views.subviews {
            if view is UILabel, view.tag == 9999 {
                view.removeFromSuperview()
            }
        }
    }
}
