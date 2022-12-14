//
//  CSLogButton.swift
//  MyMemory
//
//  Created by nakrlove on 2022/12/14.
//

import UIKit


public enum CSLogType: Int{
    case basic
    case title
    case tag
}

class CSLogButton: UIButton {
    public var logType: CSLogType = .basic
    
    public required init?(coder: NSCoder){
        super.init(coder: coder)
        
        self.setBackgroundImage(UIImage(named: "button-bg"),for: .normal)
        self.tintColor = .white
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
        
    }
    
    
    @objc func logging(_ sender: UIButton){
        switch self.logType {
        case .basic :
            NSLog("버튼이 클릭되었습니다.")
        case .title :
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle)")
        case .tag :
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
}
