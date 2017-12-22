//
//  BaseNavigationController.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2017/12/20.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.orange
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
extension UIBarButtonItem {
    
    static func item(imageName: String?, title: String?, target: AnyObject?, action: Selector,cancelHighLight: Selector? = nil) -> UIBarButtonItem {
        
        var button = UIButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        
        //如果外界传入了cancelHighLight方法，则取消按钮的高亮状态
        if let cancel = cancelHighLight {
            button.addTarget(target, action: cancel, for: .allTouchEvents)
        }
        
        
        if let title = title {
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
        if let image = imageName {
            button.setImage(UIImage(named: image), for: .normal)
            button.setImage(UIImage(named: image), for: .highlighted)
            button.setImage(UIImage(named: "\(image)_selected"), for: .selected)
        }
        if let _ = title {
            button.sizeToFit()
        }else {
            button.size = CGSize(width: 30, height: 30)
        }
        
        return UIBarButtonItem(customView: button)
    }
    
    /// 此方法仅用于导航条上有连续两个item，并且两个item的样式都是图片
    /// 的案例，外界只可以调节图片，和按钮之间的间距
    /// - Parameters:
    ///   - leftImageName: 左图片
    ///   - rightImageName: 右图片
    ///   - margin: 两个item的间距
    ///   - target: target
    ///   - action1: action1 description
    ///   - action2: action2 description
    /// - Returns: return value description
    static func items(with leftImageName: String, rightImageName: String, margin: CGFloat,target: AnyObject?, action1: Selector, action2: Selector) -> UIBarButtonItem {
        var button1 = UIButton()
        var button2 = UIButton()
        button1.addTarget(target, action: action1, for: .touchUpInside)
        button2.addTarget(target, action: action2, for: .touchUpInside)
        
        button1.setImage(UIImage(named: leftImageName), for: .normal)
        button1.setImage(UIImage(named: "\(leftImageName)"), for: .highlighted)
        button1.setImage(UIImage(named: "\(leftImageName)"), for: .selected)
        
        button2.setImage(UIImage(named: rightImageName), for: .normal)
        button2.setImage(UIImage(named: "\(rightImageName)"), for: .highlighted)
        button2.setImage(UIImage(named: "\(rightImageName)"), for: .selected)
        
        button1.sizeToFit()
        button2.sizeToFit()
        
        
        let size = CGSize(width: button1.width + margin + button2.width, height: max(button1.height, button2.height))
        let point = CGPoint(x: 0, y: 0)
        
        let customView = UIView.init(frame: CGRect.init(origin: point, size: size))
        
        button1.x = 0
        button1.centerY = customView.centerY
        button2.x = button1.width + margin
        button2.centerY = customView.centerY
        
        
        customView.addSubview(button1)
        customView.addSubview(button2)
        
        return UIBarButtonItem(customView: customView)
    }
}
