//
//  MainViewController.swift
//  XYstartMoive
//
//  Created by 李旭阳 on 2017/9/21.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        
//        self.title = "首页"
//        let item = UIBarButtonItem.item(imageName: "left_item", title: nil, action: #selector(MainViewController.goBack), target: self)
//        self.navigationItem.leftBarButtonItem = item
//
        let btn = UIButton()
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        btn.setImage(UIImage.init(named: "left_item"), for: .normal)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(MainViewController.goBack), for: .touchUpInside)
    }

    @objc func goBack(){
        DrawerViewController.share.openDrawer(duration: 0.2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

