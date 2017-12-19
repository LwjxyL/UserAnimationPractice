//
//  TM_Response.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/6.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON

enum TMResponseType{
    case NeedLogin
    case NetworkError
    case VersionError
    case Success
    case UnKnownError
    case RequestError
    case JsonTypeError
}

public struct TM_Response {
    var state:TMResponseType
    var resultJSON:JSON?
    var errorMsg:String?
    
    static var NetworkErrorResponse:TM_Response{
        return TM_Response(state: .NetworkError, resultJSON: nil, errorMsg: "网络错误，请稍后重试")
    }
    
    static var UnknowErrorResponse:TM_Response{
        return TM_Response(state: .UnKnownError, resultJSON: nil, errorMsg: "未知错误，请稍后重试")
    }
    
    static var VersionErrorResponse:TM_Response{
        return TM_Response(state: .VersionError, resultJSON: nil, errorMsg: "当前使用的版本过低，请升级后再试")
    }
    
    static var NeedLoginErrorResponse:TM_Response{
        return TM_Response(state: .NeedLogin, resultJSON: nil, errorMsg: "请登陆后再试")
    }
    
    static var JSONTypeErrorResponse:TM_Response{
        return TM_Response(state: .JsonTypeError, resultJSON: nil, errorMsg: "服务器调试中，请稍后再试")
    }
}
