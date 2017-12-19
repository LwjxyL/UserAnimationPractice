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
    case loginRequest(invCode: String?,invType: String?,mobile:String,vcode:String)//登录
    case logoutRequest()//注销登录
    case codewordRequest()//邀请口令输入页文字描述接口
    case getImgCodeRequest()//获取图形验证码接口
    case getMsgCodeRequest(hmCode:String,hmHash:String,mobile:String)//获取短信验证码接口
    case getShopListRequest(mobile:String?,vcode:String?)//获得未绑定店铺及账号列表
    case bindCheckRequest(accId:Int,fullName:String)//购物平台绑定验证
    case convertListRequest(page:Int)//我的兑换
    case convertDetailRequest(id:Int)//兑换详情
    case convertDeleteRequest(id:Int)//删除兑换记录
    case couponListRequest(page:Int,stat:Int)//我的优惠券列表
    case couponConvertListRequest(page:Int)//优惠券兑换列表
    case couponConvertRequest(id:Int)//优惠券兑换
    case getAddrListRequest()//地址列表
    case addAddrRequest(addrCity:Int,addrDist:Int?,addrDt:String,addrMobile:String,addrName:String,addrPro:Int,isDef:Bool?)//添加地址
    case delAddrRequest(id:Int)//删除地址
    case updateAddrRequest(id:Int,addrCity:Int,addrDist:Int?,addrDt:String,addrMobile:String,addrName:String,addrPro:Int,isDef:Bool?)//修改地址
    case defaultAddrRequest(id:Int)//设置默认地址
    case getRegionInfo()//地区JSON数据
    case productDetailRequest(id:Int)//商品兑换详情
    case exChangeProductRequest(id:Int,addrId:Int?)//兑换商品
    
    case idcardListRequest() // 7.1:身份证列表
    case deleteIdCardListRequest(id: Int) // 7.5:删除身份证
    case addIdCardRequest(idName: String, idNum: String, idPicBk: String, idPicFt: String, isDef: String?) //  7.3:添加身份证
    case editIdCardRequest(id: Int, idName: String?, idNum: String?, idPicBk: String?, idPicFt: String?, isDef: Bool?) // 7.4:修改身份证
    case idCardDetailRequest(id: Int) //  7.6:获取身份证信息详情
    case defIdCardRequest(id: Int) //  7.2:身份证设为默认
    case signInHomeRequest() // 签到首页信息及攻略说明
    case signInRequest() // 签到
    case inviteMsg()// 签到规则
    case inviteFriendRequest(page: Int) //邀请好友
    case shareRequest() // 邀请口令
    case getMallData(page: Int) //商品兑换列表
    case getFirstMallData(page: Int)//首页商城数据
    case userTuanDouRequest() // 团豆查询
    case makeTuanDouRequest() //赚团豆
    case hotActivityData(first: String,page: Int) //二分屏热门活动
    case getVipData() //获取会员查询数据
    case tuandouHistoryRequest(page: Int) // 团豆历史
    case userGradeRequest() //2.1:会员等级说明会员等级说明
    case animationLevelRequest()//首页动画元素
    case imgUpload(upload_type:String,image: Data,image_input_title: String,image_type:String)// 上传图片
    case hotActivityContentRequest(activityID: Int)//热门活动详情
}

extension TTmamaAPI:TargetType{
    var baseURL: URL{
        return ServerURL.mainUrl
    }
    
    var path: String{
        return "topapi"
    }
    
    var method: Moya.Method{
        switch self {
        case .imgUpload:
            return .post
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]?{
        var param = [String:Any]()
        param["platform"] = "ios"
        param["v"] = "v1"//Bundle.main.infoDictionary!["CFBundleShortVersionString"]!
        param["format"] = "json"
        switch self {
        case .loginRequest(let invCode,let invType,let mobile,let vcode):
            param["method"] = "user.login"
            param["invCode"] = invCode
            param["invType"] = invType
            param["mobile"] = mobile
            param["vcode"] = vcode
            return param
        case .logoutRequest:
            param["method"] = "user.logout"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .codewordRequest:
            param["method"] = "member.invitecode.getIntro"
            return param
        case .getImgCodeRequest:
            param["method"] = "user.vcode"
            return param
        case .getMsgCodeRequest(let hmCode,let hmHash, let mobile):
            param["method"] = "user.sendSms"
            param["hmCode"] = hmCode
            param["hmHash"] = hmHash
            param["mobile"] = mobile
            return param
        case .getShopListRequest(let mobile, let vcode):
            param["method"] = "user.unboundShop"
            param["token"] = TTmamaUser.shared.user.token
            param["mobile"] = mobile
            param["vcode"] = vcode
            return param
        case .bindCheckRequest(let accId, let fullName):
            param["method"] = "user.bindchk"
            param["token"] = TTmamaUser.shared.user.token
            param["accId"] = accId
            param["fullName"] = fullName
            return param
        case .convertListRequest(let page):
            param["method"] = "member.goods.list"
            param["token"] = TTmamaUser.shared.user.token
            param["page"] = page
            return param
        case .convertDetailRequest(let id):
            param["method"] = "member.goods.detail"
            param["token"] = TTmamaUser.shared.user.token
            param["ex_id"] = id
            return param
        case .convertDeleteRequest(let id):
            param["method"] = "member.goods.delete"
            param["token"] = TTmamaUser.shared.user.token
            param["exId"] = id
            return param
        case .couponListRequest(let page, let stat):
            param["method"] = "member.coupon.list"
            param["token"] = TTmamaUser.shared.user.token
            param["page"] = page
            param["stat"] = stat
            return param
        case .couponConvertListRequest(let page):
            param["method"] = "shop.coup.list"
            param["token"] = TTmamaUser.shared.user.token
            param["page"] = page
            return param
        case .couponConvertRequest(let id):
            param["method"] = "shop.coup.exchg"
            param["token"] = TTmamaUser.shared.user.token
            param["cou_id"] = id
            return param
        case .getAddrListRequest():
            param["method"] = "member.address.list"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .addAddrRequest(let addrCity, let addrDist, let addrDt, let addrMobile, let addrName, let addrPro, let isDef):
            param["method"] = "member.address.create"
            param["token"] = TTmamaUser.shared.user.token
            param["addrCity"] = addrCity
            param["addrDist"] = addrDist
            param["addrDt"] = addrDt
            param["addrMobile"] = addrMobile
            param["addrName"] = addrName
            param["addrPro"] = addrPro
            param["isDef"] = isDef == true ? "true":"false"
            return param
        case .delAddrRequest(let id):
            param["method"] = "member.address.delete"
            param["token"] = TTmamaUser.shared.user.token
            param["addr_id"] = id
            return param
        case .updateAddrRequest(let id, let addrCity, let addrDist, let addrDt, let addrMobile, let addrName, let addrPro, let isDef):
            param["method"] = "member.address.update"
            param["token"] = TTmamaUser.shared.user.token
            param["addr_id"] = id
            param["addrCity"] = addrCity
            param["addrDist"] = addrDist
            param["addrDt"] = addrDt
            param["addrMobile"] = addrMobile
            param["addrName"] = addrName
            param["addrPro"] = addrPro
            param["isDef"] = isDef == true ? "true":"false"
            return param
        case .defaultAddrRequest(let id):
            param["method"] = "member.address.setDefault"
            param["token"] = TTmamaUser.shared.user.token
            param["addr_id"] = id
            return param
        case .getRegionInfo():
            param["method"] = "region.json"
            return param
        case .productDetailRequest(let id):
            param["method"] = "shop.goods.detail"
            param["token"] = TTmamaUser.shared.user.token
            param["gId"] = id
            return param
        case .exChangeProductRequest(let id, let addrId):
            param["method"] = "shop.goods.exchg"
            param["token"] = TTmamaUser.shared.user.token
            param["gId"] = id
            param["addrId"] = addrId
            return param
            
        case .idcardListRequest(_):
            param["method"] = "member.idcard.list"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .deleteIdCardListRequest(let id):
            param["method"] = "member.idcard.delete"
            param["token"] = TTmamaUser.shared.user.token
            param["idId"] = id
            return param
        case .addIdCardRequest(let idName, let idNum, let idPicBk, let idPicFt, let isDef):
            param["method"] = "member.idcard.create"
            param["token"] = TTmamaUser.shared.user.token
            param["idName"] = idName
            param["idNum"] = idNum
            param["isDef"] = isDef
            param["idPicBk"] = idPicBk
            param["idPicFt"] = idPicFt
            return param
        case .editIdCardRequest(let id, let idName, let idNum, let idPicBk, let idPicFt, let isDef):
            param["method"] = "member.idcard.update"
            param["token"] = TTmamaUser.shared.user.token
            param["idName"] = idName
            param["idNum"] = idNum
            param["isDef"] = isDef
            param["idId"] = id
            param["idPicBk"] = idPicBk
            param["idPicFt"] = idPicFt
            return param
        case .idCardDetailRequest(let id):
            param["method"] = "member.idcard.get"
            param["token"] = TTmamaUser.shared.user.token
            param["idId"] = id
            return param
        case .defIdCardRequest(let id):
            param["method"] = "member.idcard.setDefault"
            param["token"] = TTmamaUser.shared.user.token
            param["idId"] = id
            return param
            
        case .getMallData(let page):
            param["method"] = "shop.goods.list"
            param["token"] = TTmamaUser.shared.user.token
            param["page"] = page
            return param
        case .getFirstMallData(let page):
            param["method"] = "shop.home"
            param["page"] = page
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .signInHomeRequest():
            param["method"] = "member.checkin.homePage"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .signInRequest():
            param["method"] = "member.checkin.checkin"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .inviteMsg():
            param["method"] = "member.invitecode.getGiftIntro"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .inviteFriendRequest(let page):
            param["page"] = page
            param["method"] = "member.invitecode.history"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .shareRequest():
            param["method"] = "member.invitecode.get"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .userTuanDouRequest():
            param["method"] = "member.point.dou"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .makeTuanDouRequest():
            param["method"] = "member.point.how"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .tuandouHistoryRequest(let page):
            param["page"] = page
            param["method"] = "member.point.detail"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .getVipData() :
            param["method"] = "member.getMemberCardInfo"
            param["token"] = TTmamaUser.shared.user.token
            return param
        case .hotActivityData(let first, let page):
            param["method"] = "activity.hot.list"
            param["first"] = first
            param["page"] = page
            return param
        case .userGradeRequest():
            param["method"] = "member.grade.list"
            param["token"] = TTmamaUser.shared.user.token
            return param
            
        case .animationLevelRequest():
            param["token"] = TTmamaUser.shared.user.token
            param["method"] = "user.info"
            return param
        case .imgUpload(let upload_type, _, let image_input_title,let image_type):
            param["method"] = "image.upload"
            param["token"] = TTmamaUser.shared.user.token
            param["upload_type"] = upload_type
            param["image_input_title"] = image_input_title
            param["image_type"] = image_type
            return param
        case .hotActivityContentRequest(let id):
            param["method"] = "activity.hot.info"
            param["hot_id"] = id
            return param
            
//        default :return param
        }
        
    }
    
    var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task{
        switch self {
        case .imgUpload(_, let image, let image_input_title, _):
            var arr: [MultipartFormData] = []
            arr.append(MultipartFormData(provider: .data(image), name: "image", fileName: image_input_title, mimeType: "image/png"))
            if arr.count == 0 {
                arr.append(MultipartFormData.init(provider: .data(Data()), name: "nil"))
            }
            return .upload(.multipart(arr))
        default:
            return .request
        }
        
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
