//
//  MoyaTTmamaAPIService.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/10/21.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result

// 注意: 项目正式启动需要重新配置

struct ServerURL {
    static let mainUrl: URL = URL(string: "https://clubmock.ittmom.com")!
}

enum TTmamaAPI{
    case idcardListRequest() // 7.1:身份证列表
    
}

extension TTmamaAPI:TargetType{
    var baseURL: URL{
        return ServerURL.mainUrl
    }
    
    var path: String{
        return "topapi"
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var parameters: [String : Any]?{
        var param = [String:Any]()
        param["platform"] = "ios"
        param["v"] = "v1"//Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        param["format"] = "json"
        switch self {
        case .idcardListRequest(_):
            param["method"] = "member.idcard.list"
            param["token"] = "3d868621b5f48312bb21256da89a16263c59dc048e8850243be8079a5c74d079"
            return param
        }
    }
    
    var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task{
        return .request
    }
}

class TTmamaNetAPIProvider{
    private static let shareInstance = TTmamaNetAPIProvider()
    private init(){
        let networkplugin = NetworkActivityPlugin{
            (change) in
            switch change{
            case .began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        shareProvider = MoyaProvider<TTmamaAPI>(plugins:[networkplugin])
        rxShareProvider = RxMoyaProvider<TTmamaAPI>(plugins:[networkplugin])
    }
    private var shareProvider:MoyaProvider<TTmamaAPI>
    private var rxShareProvider:RxMoyaProvider<TTmamaAPI>
    
    class var provider:MoyaProvider<TTmamaAPI>{
        return shareInstance.shareProvider
    }
    class var rxprovider:RxMoyaProvider<TTmamaAPI>{
        
        return shareInstance.rxShareProvider
    }
}
