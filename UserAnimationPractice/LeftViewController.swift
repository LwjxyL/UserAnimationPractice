//
//  LeftViewController.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2018/1/2.
//  Copyright © 2018年 李文静. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    var tableView: UITableView?

    var imageArray: [String] {
        let arr = ["convert_icon","coupon_icon","idcard_icon","ress_icon","setting_icon"]
        return arr
    }
    var strArray: [String] {
        let arr = ["兑换记录","我的卡券包","身份认证","地址管理","设置"]
        return arr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
//        self.tableView?.separatorStyle = .none // 分割线
        self.tableView?.register(UINib(nibName:"LeftCell",bundle: nil), forCellReuseIdentifier: "LeftCell")
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.tableView?.rowHeight = 90
        self.view.addSubview(tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftCell", for: indexPath) as! LeftCell
        cell.img.image = UIImage.init(named: imageArray[indexPath.row])
        cell.lab.text = strArray[indexPath.row]
        return cell
    }
}
