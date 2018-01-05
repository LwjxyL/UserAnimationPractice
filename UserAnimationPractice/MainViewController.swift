//
//  MainViewController.swift
//  XYstartMoive
//
//  Created by 李旭阳 on 2017/9/21.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let array = ["抽屉效果": 1,"网络接口调用": 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
        self.title = "首页"
        
//        let btn = UIButton()
//        btn.frame = CGRect(x: 0, y: 10, width: 60, height: 60)
//        btn.setImage(UIImage.init(named: "left_item"), for: .normal)
//        self.view.addSubview(btn)
//        btn.addTarget(self, action: #selector(MainViewController.goBack), for: .touchUpInside)
        
        setUpUI()
    }
    @objc func goBack(){
        DrawerViewController.share.openDrawer(duration: 0.2)
    }

    func setUpUI(){
        var btnY = CGFloat(200)
        for (name,i) in array {
            let button = UIButton()
            button.tag = i + 100
            button.setTitle("\(name)", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.frame = CGRect(x: (UIScreen.main.bounds.size.width - 150)/2 , y: btnY, width: 150, height: 36)
            button.layer.cornerRadius = 10.0
            button.layer.borderWidth = 1.0
            button.layer.masksToBounds = true
            button.layer.borderColor = UIColor.white.cgColor
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(MainViewController.btnClick(sender:)), for: .touchUpInside)
            self.view.addSubview(button)
            btnY = button.frame.maxY + 10
        }
    }
    
    @objc func btnClick(sender:UIButton){
        let tags = sender.tag
        switch tags {
        case 101:
           DrawerViewController.share.openDrawer(duration: 0.2)
        case 102:
            let vc = IDcardViewController()
//            let nav = BaseNavigationController.init(rootViewController: vc)
//            self.view.window?.rootViewController = nav
            self.navigationController?.pushViewController(vc, animated: true)
            print("dd")
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

