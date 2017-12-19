//
//  TMApiUnit.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/4.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import SwiftyJSON


class TMApiUnit{
    let disposeBag = DisposeBag()
    var apiRequest:TTmamaAPI!
    
    private let runningState:Variable<Bool> = Variable(false)
    private let requestApi = PublishSubject<TTmamaAPI>()
    
    
    var isRunning:Bool{
        return runningState.value
    }
    var observableRunningState:Observable<Bool>{
        return runningState.asObservable().distinctUntilChanged()
    }
    var tm_Response:Observable<TM_Response>
    
    var successJSON:Observable<JSON>{
        return tm_Response
            .filter { (response) -> Bool in
                if response.state == TMResponseType.Success{
                    return true
                }else {
                    return false
                }
            }
            .map {
                return $0.resultJSON!
        }
    }
    
    var errorResponse:Observable<TM_Response>{
        return tm_Response.filter { (response) ->Bool in
            if response.state != .Success {
                return true
            }else {
                return false
            }
        }
    }
    
    
    init(){
        
        tm_Response = requestApi
            .map{
                return TTmamaNetAPIProvider.rxprovider.request($0)
                    .mapTMResponse()
                    .catchErrorJustReturn(TM_Response.NetworkErrorResponse)
            }
            .switchLatest()
            .shareReplay(1)
        
        
        _ = requestApi
            .subscribe(){[unowned self] event in
                switch event {
                case .next(_):
                    self.runningState.value = true
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
        
        _ = tm_Response
            .subscribe(){[unowned self] event in
                switch event {
                case .next(_):
                    self.runningState.value = false
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
        
        errorResponse
            .subscribe(onNext:{resp in
                TMProgressHUD.showErrorMsg(msg: resp.errorMsg)
            }).addDisposableTo(disposeBag)
        
    }
    
    convenience init(api:TTmamaAPI) {
        self.init()
        apiRequest = api
    }
    
    func start(){
        if apiRequest != nil {
            requestApi.onNext(apiRequest)
        }
        
    }
}
