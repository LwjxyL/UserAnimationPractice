//
//  WangAPIService.swift
//  TTmama_IntegralMall_iOS
//
//  Created by ittmomWang on 2017/7/24.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result



enum WangAPI{

    case getMallData(page: Int) //首页商城数据
}

extension WangAPI:TargetType{
    var baseURL: URL{
        return ServerURL.mainUrl
    }
    
    var path: String{
        switch self {
        case .getMallData(page: _):
            return "api/shop"
        }
    }
    
    var method: Moya.Method{
        return .get
    }
    
    var parameters: [String : Any]?{
        var param = [String:Any]()
        param["platform"] = "ios"
        param["version"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        switch self {
        case .getMallData(let page):
            param["page"] = page
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

class WangNetAPIProvider{
    private static let shareInstance = WangNetAPIProvider()
    private init(){
        let networkplugin = NetworkActivityPlugin{
            (change) in
            switch change{
            case .began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        shareProvider = MoyaProvider<WangAPI>(plugins:[networkplugin])
        rxShareProvider = RxMoyaProvider<WangAPI>(plugins:[networkplugin])
        
    }
    private var shareProvider:MoyaProvider<WangAPI>
    private var rxShareProvider:RxMoyaProvider<WangAPI>
    
    class var provider:MoyaProvider<WangAPI>{
        return shareInstance.shareProvider
    }
    class var rxprovider:RxMoyaProvider<WangAPI>{
        return shareInstance.rxShareProvider
    }
}




