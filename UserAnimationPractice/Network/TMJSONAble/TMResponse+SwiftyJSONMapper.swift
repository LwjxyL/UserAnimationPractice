//
//  TMResponse+SwiftyJSONMapper.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/6.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

extension TM_Response{
    func mapObject<T:TMJSONAble>(type:T.Type) -> T? {
        guard let json = resultJSON else {
            return nil
        }
        return T(jsonData:json)
    }
    
    func mapArray<T:TMJSONAble>(type:T.Type) -> [T]?{
        guard let jsonArray = resultJSON?.arrayValue else {
            return nil
        }
        
        var objArray = [T]()
        
        for v in jsonArray{
            if let t = T(jsonData:v){
                objArray.append(t)
            }
        }
        return objArray
    }
}


