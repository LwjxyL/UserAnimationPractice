//
//  TTmamaUser.swift
//  TTmama_IntegralMall_iOS
//
//  Created by yaofangfang on 2017/8/2.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift

struct UserModel:TMJSONAble{
    var hasBind:Bool?
    var hasRecd:Bool?
    var token:String?
    init?(jsonData: JSON) {
        hasBind = jsonData["hasBind"].bool
        hasRecd = jsonData["hasRecd"].bool
        token = jsonData["token"].string
    }
}

class TTmamaUser:NSObject {
    
    let disBag = DisposeBag()
    
    var loginUnit = TMApiUnit()
    
    static let shared = TTmamaUser.init()
    
    var dataBack = PublishSubject<(Int)>()
    
    var user:UserModel!
    
    private override init() {
        super.init()
        self.loginUnit.observableRunningState.subscribe(onNext:{isrunning in
            if isrunning {
                TMProgressHUD.showLoading(msg: nil)
            }
        }).addDisposableTo(self.disBag)
        
        self.loginUnit.successJSON
            .subscribe(onNext:{ [weak self] resultJSON in
                self?.user = UserModel.init(jsonData: resultJSON)
                self?.login = true
                self?.dataBack.onNext(1)
                if let u = self?.user{
                    UserDefaults.standard.set(["hasBind":u.hasBind!,"hasRecd":u.hasRecd!,"token":u.token!], forKey: "user")
                    UserDefaults.standard.synchronize()
                }
                TMProgressHUD.hideHUD()
            }).addDisposableTo(self.disBag)
        
        if let user = UserDefaults.standard.object(forKey: "user") as? [String:Any]{
            self.user = UserModel.init(jsonData: JSON.null)!
            self.user.hasBind = user["hasBind"] as? Bool
            self.user.hasRecd = user["hasRecd"] as? Bool
            self.user.token = user["token"] as? String
            self.login = true
        }
        
    }
    
    private var login = false
    
    //MARK: 用户登录相关方法
    /**
     判断当前app是否已经在用户登录情况下
     
     - returns: 用户已登录返回true
     */
    func isLogin()->Bool{
        return self.login
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "user")
        self.user = nil
        self.login = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sb = UIStoryboard.init(name: "LoginStoryboard", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "Login")
        appDelegate.window?.rootViewController = login
    }
    
    func loadData(code:String?,type:String?,mobile:String,vcode:String) {
        let api = TTmamaAPI.loginRequest(invCode: code, invType: type, mobile: mobile, vcode: vcode)
        self.loginUnit.apiRequest = api
        self.loginUnit.start()
    }
    
}
