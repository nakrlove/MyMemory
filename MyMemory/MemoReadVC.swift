//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by nakrlove on 2022/12/01.
//

import UIKit

class MemoReadVC: UIViewController {
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var contents: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    
    var param: MemoData?
    
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        self.navigationController?.title = dateString
    }


}
