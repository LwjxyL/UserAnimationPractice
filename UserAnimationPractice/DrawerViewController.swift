//
//  DrawerViewController.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2018/1/3.
//  Copyright © 2018年 李文静. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    static let share = DrawerViewController()
    var mainView: MainViewController?
    var leftView: LeftViewController?
    var maxWidth: CGFloat?
    var coverButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCoverButton()
    }

    
    func openDrawer(duration:CGFloat) {
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveLinear, animations: {
            self.mainView?.view.transform = CGAffineTransform.init(translationX: self.maxWidth!, y: 0)
            self.leftView?.view.transform = CGAffineTransform.identity
        }) { (Bool) in
            self.setCoverButton()
            self.mainView?.view.addSubview(self.coverButton!)
        }
    }
    
    func setCoverButton (){
        guard self.coverButton != nil else {
            self.coverButton = UIButton.init()
            self.coverButton?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.coverButton?.addTarget(self, action: #selector(DrawerViewController.closeDrawer), for: .touchUpInside)
            return
        }
    }

    
    @objc func closeDrawer() {
        print("关闭抽屉")
    }
    
    class func drawerWithOpenViewController(leftVC: LeftViewController, mainVC: MainViewController,drawerMaxWidth:CGFloat) -> DrawerViewController {
        
        let drawerVC = DrawerViewController.share
        
        drawerVC.leftView = leftVC
        drawerVC.mainView = mainVC
        drawerVC.maxWidth = drawerMaxWidth
        
        drawerVC.view.addSubview(leftVC.view)
        drawerVC.view.addSubview(mainVC.view)
        drawerVC.addChildViewController(leftVC)
        drawerVC.addChildViewController(mainVC)
        
        return drawerVC
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
}
