//
//  Response+MapTMResponse.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/6.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON


extension Response {
    static var NetworkErrorResponse:Response{
        return Response(statusCode: 9999, data: Data())
    }
    func mapTMResponse(isDebug:Bool = false)->TM_Response{
        if self.statusCode == 9999{
            return TM_Response.NetworkErrorResponse
        }else{
            debugPrint(response?.url?.absoluteString as Any)
            do{
                let js = try JSON(self.mapJSON())
                debugPrint(js)
                if let rsp = js["code"].number {
                    if rsp == 200{
                        return TM_Response(state: .Success, resultJSON: js["data"], errorMsg: nil)
                    }else if rsp == 2019{
                        TTmamaUser.shared.logout()
                        return TM_Response(state: .NeedLogin, resultJSON: nil, errorMsg: js["msg"].string)
                    }else{
                        return TM_Response(state: .RequestError, resultJSON: nil, errorMsg: js["msg"].string)
//                        return TM_Response(state: .JsonTypeError, resultJSON: nil, errorMsg: js["msg"].string)
                    }
                    ///注意： 静态接口调试阶段暂时关闭错误类型处理，后续需要重新梳理
                    
//                    if rsp == 200{
//                        return TM_Response(state: .Success, resultJSON: js["data"], errorMsg: nil)
////                    }else if let res = js["res"].string{
////                        debugPrint(response?.url?.absoluteString as Any)
////                        debugPrint(js)
////                        if res == "version_error"{
////                            return TM_Response.VersionErrorResponse
////                        }else if res == "need_login"{
////                            return TM_Response.NeedLoginErrorResponse
////                        }else{
////                            let msg = js["msg"].string
////                            return TM_Response(state: .RequestError, resultJSON: nil, errorMsg: msg)
////                        }
////                    }else if js["msg"].string == "无效登录"{
////                        return TM_Response.NeedLoginErrorResponse
////                    }else if js["msg"].string == "password incorrect" || js["msg"].string == "user not exist"{
////                        return TM_Response(state: .UnKnownError, resultJSON: nil, errorMsg: "用户名或密码错误，请检查后再试")
////                    }else if js["msg"].string == "version is null"{
////                        return TM_Response(state: .Success, resultJSON: js["data"], errorMsg: nil)
//                    }else {
//                        return TM_Response(state: .UnKnownError, resultJSON: nil, errorMsg: js["msg"].string)
//                    }
                    
                }else {
                     return TM_Response(state: .RequestError, resultJSON: nil, errorMsg: js["msg"].string)
                }
            }catch(_){
                return TM_Response.JSONTypeErrorResponse
            }
        }
        return TM_Response.UnknowErrorResponse
    }
}
