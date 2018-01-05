//
//  IDcardListModel.swift
//  TTmama_IntegralMall_iOS
//
//  Created by 李旭阳 on 2017/7/25.
//  Copyright © 2017年 ittmomProject. All rights reserved.
//

import Foundation
import SwiftyJSON

struct IDcardListModel: TMJSONAble {
    var idcardModel =  [IDCardModel]()
    
    init?(jsonData: JSON) {
        if jsonData["page"].count>0{
            var arr = [IDCardModel]()
            for (_,value) in jsonData["page"] {
                let idcard = IDCardModel(jsonData: value)
                arr.append(idcard!)
            }
            idcardModel = arr
        }
    }
}

struct IDCardModel: TMJSONAble {
    var idId: Int?
    var idName: String?
    var idNum: String?
    var isDef: Bool?
    
    init?(jsonData: JSON) {
        self.idId = jsonData["idId"].int
        self.idName = jsonData["idName"].string
        self.idNum = jsonData["idNum"].string
        self.isDef = jsonData["isDef"].bool
    }
}

struct DetailIdcardModel: TMJSONAble {
    
    var idName: String?
    var idNum: String?
    var isDef: Bool?
    var idPicBk: String?
    var idPicFt: String?
    
    init?(jsonData: JSON) {
        self.idPicBk = jsonData["idPicBk"].string
        self.idPicFt = jsonData["idPicFt"].string
        self.idName = jsonData["idName"].string
        self.idNum = jsonData["idNum"].string
        self.isDef = jsonData["isDef"].bool
    }
}

struct UpLoadImgModel: TMJSONAble {
    var image_id: String?
    var url: String?
    var t_url: String?
    
    init?(jsonData: JSON) {
        self.image_id = jsonData["image_id"].string
        self.url = jsonData["url"].string
        self.t_url = jsonData["t_url"].string
    }
}

