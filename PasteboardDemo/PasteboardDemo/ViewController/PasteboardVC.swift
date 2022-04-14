//
//  PasteboardVC.swift
//  PasteboardDemo
//
//  Created by Molder on 2022/4/13.
//

import UIKit

class PasteboardVC: UIViewController {
    private enum ButtonActionType: Int {
        case single = 0
        case image
        case multiple
        case imageDataOutput
        case imageDataInput
    }
    @IBOutlet weak var singleLabel: UILabel!
    @IBOutlet weak var singleLabelButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewButton: UIButton!
    
    @IBOutlet weak var multipleFirstLabel: UILabel!
    @IBOutlet weak var multipleSecondLabel: UILabel!
    @IBOutlet weak var multipleButton: UIButton!
    private let multipleStr = ["這是第一行", "這是第二行"]
    
    @IBOutlet weak var imageDataLabel: UILabel!
    private let imageName = "test01"
    private var imageData: Data?
    
    @IBOutlet weak var binaryImageView: UIImageView!
    @IBOutlet weak var binaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "剪貼簿"
        setData()
    }
    
    private func setData() {
        singleLabel.text = "Hello"
        multipleFirstLabel.text = multipleStr.first
        multipleSecondLabel.text = multipleStr.last

        let path = Bundle.main.path(forResource: imageName, ofType: "JPG")!
        let url = URL(fileURLWithPath: path)
        do {
            let originalData = try Data(contentsOf: url)
            let originalImage = UIImage(data: originalData) ?? UIImage()
            let tmpImage = originalImage.imageWithNewSize(size: CGSize(width: 1920, height: 1080))
            guard let data = tmpImage?.compressImageMid(maxLength: 1920 * 1080), let newImage = UIImage(data: data) else { return }
            imageData = data
            imageView.image = newImage
        } catch {
            debugPrint("something wrong")
        }
        
        binaryImageView.layer.borderWidth = 1
        binaryImageView.layer.borderColor = UIColor.gray.cgColor
        binaryButton.isEnabled = false
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let type = ButtonActionType(rawValue: sender.tag)
        var toastText = ""
        switch type {
        case .single:
            UIPasteboard.general.string = singleLabel.text
            toastText = "單行文字已複製"
        case .image:
            UIPasteboard.general.image = imageView.image
            toastText = "圖片已複製"
        case .multiple:
            UIPasteboard.general.strings = multipleStr
            toastText = "多行文字已複製"
        case .imageDataOutput:
            let dataBytes = imageData?.count ?? 0
            imageDataLabel.text = "Copy : image binary \(dataBytes) bytes"
            UIPasteboard.general.setData(imageData!, forPasteboardType: imageName)
            toastText = "圖片的二進制資料已複製"
        case .imageDataInput:
            imageData = nil
            imageData = UIPasteboard.general.data(forPasteboardType: imageName)
            binaryImageView.image = UIImage(data: imageData ?? Data())
            toastText = "已貼上二進制資料轉為圖片"
        default:
            break
        }
        self.view.showToast(text: toastText)
        binaryButton.isEnabled = type == .imageDataOutput ? true : false
    }
    
    @IBAction func clearClicked(_ sender: UIButton) {
        binaryImageView.image = UIImage()
    }
    
}
