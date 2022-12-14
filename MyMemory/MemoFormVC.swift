//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by nakrlove on 2022/12/01.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextViewDelegate {

    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        // Do any additional setup after loading the view.
        let bgImage = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle: style])
        self.contents.text = ""
        
    }


    @IBAction func save(_ sender: Any) {
        
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요!", preferredStyle: .alert)
            alert.setValue(alertV, forKey: "contentViewController")
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert ,animated: true)
            return
        }
        
        let data = MemoData()
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func pick(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
        
    }
    
    func textViewDidChange(_ textView: UITextView){
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = self.subject
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
    
    //네비게이션 바의 토클 처리를 하고 있습니다.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts){
            bar?.alpha = ( bar?.alpha == 0 ? 1: 0 )
        }
    }
}
