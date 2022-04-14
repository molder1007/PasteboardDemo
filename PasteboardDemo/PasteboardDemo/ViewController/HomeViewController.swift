//
//  HomeViewController.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/2/19.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private enum FuncType: Int {
        case pasteboard = 0
        case label
        case image
        case cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellStrArr = ["剪貼簿", "Lable文字複製", "Image圖片複製", "TableCell文字複製"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellStrArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.text = cellStrArr[indexPath.row]
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = cellStrArr[indexPath.row]
        }
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = FuncType(rawValue: indexPath.row)
        switch type {
        case .pasteboard:
            let vc = PasteboardVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .label:
            let vc = CopyLabelVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .image:
            let vc = CopyImageViewVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case .cell:
            let vc = CopyTableViewCellVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}






