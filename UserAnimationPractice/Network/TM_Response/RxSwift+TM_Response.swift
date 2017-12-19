//
//  RxSwift+TM_Response.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/6.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import RxSwift
import Moya


public extension ObservableType where E == Response{
    public func mapTMResponse(isDebug:Bool = false)->Observable<TM_Response>{
        return flatMap { response->Observable<TM_Response> in
            return Observable.just(response.mapTMResponse(isDebug:isDebug))
        }
    }
}
