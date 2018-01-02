//
//  UIBarButtonItem+Extension.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2017/12/28.
//  Copyright © 2017年 李文静. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    static func item(imageName: String?, title: String?, action: Selector,target: AnyObject?) -> UIBarButtonItem {
        
        let button = UIButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        
        
        if let str = title {
            button.setTitle(str, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
        if let imgName = imageName {
            button.setImage(UIImage.init(named: imgName), for: .normal)
            button.setImage(UIImage.init(named: imgName), for: .highlighted)
            button.setImage(UIImage.init(named: "\(imgName)_selector"), for: .selected)
        }
        
//        if let _ = title {
//            button.sizeToFit()
//        } else {
//            button.frame.size = CGSize(width: 10, height: 10)
//        }
        
        return UIBarButtonItem(customView: button)
        
    }
}
