//
//  IDcardViewService.swift
//  TTmama_IntegralMall_iOS
//
//  Created by 李旭阳 on 2017/7/27.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import Alamofire

class IDcardViewService {
    static let share = IDcardViewService()
    let disPoseBag = DisposeBag()
    var idCardListUnit = TMApiUnit()
    var dataBack = PublishSubject<(IDcardListModel)>()
    
    init() {
        
        // 身份证列表
        self.idCardListUnit.observableRunningState.subscribe (onNext:{ isrunning in
            if isrunning {
                TMProgressHUD.showLoading(msg: nil)
            }
        }).addDisposableTo(disPoseBag)
        self.idCardListUnit.successJSON.subscribe (onNext:{ [weak self] resultJSON in
            if let idcard = IDcardListModel.init(jsonData: resultJSON) {
                self?.dataBack.onNext(idcard)
            }
            TMProgressHUD.hideHUD()
        }).addDisposableTo(disPoseBag)
        
        
    }
    
    // 身份证列表
    func loadListData() {
        let api = TTmamaAPI.idcardListRequest()
        self.idCardListUnit.apiRequest = api
        self.idCardListUnit.start()
    }
    
    
}
