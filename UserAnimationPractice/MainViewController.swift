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
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        let item = UIBarButtonItem.item(imageName: "left-arrow", title: nil, action: #selector(MainViewController.goBack), target: self)
        self.navigationItem.leftBarButtonItem = item
    }

    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

