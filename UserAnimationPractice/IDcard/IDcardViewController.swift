//
//  IDcardViewController.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2018/1/5.
//  Copyright © 2018年 李文静. All rights reserved.
//

import UIKit
import RxSwift

class IDcardViewController: UIViewController {

    var tableView: UITableView?
    var idCardModel = [IDCardModel]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "示例数据"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.item(imageName: "left-arrow", title: nil, action: #selector(IDcardViewController.goBack), target: self)
        self.tableView = UITableView.init(frame: UIScreen.main.bounds)
        self.view.addSubview(self.tableView!)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        setData()
    }

    func setData() {
        IDcardViewService.share.dataBack.subscribe(onNext: { [weak self] (data) in
            self?.idCardModel = data.idcardModel
            self?.tableView?.reloadData()
        }).addDisposableTo(disposeBag)
        IDcardViewService.share.loadListData()
    }
    
    @objc func goBack(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

}

extension IDcardViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idCardModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cellIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
        }
        cell!.textLabel?.text = "名字:\(idCardModel[indexPath.row].idName ?? "name")"
        return cell!
    }
}

