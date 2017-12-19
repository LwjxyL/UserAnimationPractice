//
//  TMProgressHUD.swift
//  TTmama_Mall_iOS
//
//  Created by Dennis Wang on 2016/11/2.
//  Copyright © 2016年 Dennis Wang. All rights reserved.
//

import Foundation
import MBProgressHUD

class TMProgressHUD {
    
    fileprivate enum HUDStatus{
        case Success
        case Error
        case Info
        case Waiting
        case Text
    }
    
    fileprivate class func show(status:HUDStatus,msg:String?){
        DispatchQueue.main.async {
            let msgShowDuring:TimeInterval = 1.5
            var hud:MBProgressHUD! = MBProgressHUD(for: UIApplication.shared.keyWindow!)
            if  hud == nil {
                hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
                initialize(hud: hud)
            }
            
            hud.label.text = msg
            hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            switch status{
            case .Waiting:
                hud.mode = .indeterminate
                hud.bezelView.color = UIColor.clear
            case .Success:
                hud.mode = .customView
                let checkImage = UIImage(named: "checkMark")
                let checkView = UIImageView(image: checkImage)
                hud.customView = checkView
                hud.hide(animated: true, afterDelay: msgShowDuring)
            case .Text:
                hud.mode = .text
                
                hud.hide(animated: true, afterDelay: msgShowDuring)
            case .Error:
                hud.mode = .customView
                let checkImage = UIImage(named: "CrossMark")
                let checkView = UIImageView(image: checkImage)
                hud.customView = checkView
                hud.hide(animated: true, afterDelay: msgShowDuring)
            case .Info:
                hud.mode = .customView
                let checkImage = UIImage(named: "checkMark")
                let checkView = UIImageView(image: checkImage)
                hud.customView = checkView
                hud.hide(animated: true, afterDelay: msgShowDuring)
                
            }
        }
    }
    
    fileprivate class func initialize(hud:MBProgressHUD){
        let minHudSize = CGSize(width: 100, height: 100)
        let msgSize:CGFloat = 14
        let hudBackgroudColor = UIColor.black.withAlphaComponent(0.6)
        
        hud.backgroundView.style = .solidColor
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = hudBackgroudColor
        hud.minSize = minHudSize
        hud.label.font = UIFont.systemFont(ofSize: msgSize)
        hud.contentColor = UIColor.white
        
    }
    
    class func showLoading(msg:String?){
        show(status: .Waiting,msg:msg)
    }
    
    class func showSuccess(msg:String?){
        show(status: .Success, msg: msg)
    }
    
    class func showJustText(msg:String){
        show(status: .Text, msg: msg)
    }
    
    class func showInfoMsg(msg:String){
        show(status: .Info, msg: msg)
    }
    
    class func showErrorMsg(msg:String?){
        show(status: .Error, msg: msg)
    }
    
    class func hideHUD(){
        DispatchQueue.main.async {
            if let hud  = MBProgressHUD(for: UIApplication.shared.keyWindow!){
                hud.hide(animated: true)
            }
        }
    }
}
