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
                        return TM_Response(state: .NeedLogin, resultJSON: nil, errorMsg: js["msg"].string)
                    }else{
                        return TM_Response(state: .RequestError, resultJSON: nil, errorMsg: js["msg"].string)
                    }
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
