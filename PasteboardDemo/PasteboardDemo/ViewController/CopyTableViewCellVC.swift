//
//  CopyTableViewCellVC.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/14.
//

import UIKit

class CopyTableViewCellVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private let strArr = ["甲","乙","丙","丁"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Copy TableView Cell Text"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.accessoryType = .none
        
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.text = strArr[indexPath.row]
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = strArr[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        UIPasteboard.general.string = strArr[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
