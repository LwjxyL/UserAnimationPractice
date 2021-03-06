//
//  ViewController.swift
//  XYstartMoive
//
//  Created by 李旭阳 on 2017/9/21.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var playerView:AVPlayerViewController?
    var player: AVPlayer?
    var movieUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: movieUrl!)
        //设置大小和位置（全屏）
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        //添加到界面上
        self.view.layer.addSublayer(playerLayer)
        //开始播放
        player.play()
        self.setupLoginView()
        
    }
    
//    // MARK: - 添加进入应用按钮
    func setupLoginView(){
        let btn = UIButton.init(frame: CGRect(x: 24, y: UIScreen.main.bounds.size.height - 32-48, width: UIScreen.main.bounds.size.width-48, height: 48))
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 24
        btn.layer.borderColor = UIColor.white.cgColor
        btn.setTitle("进入应用", for: .normal)
        btn.alpha = 0
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(ViewController.btnClick(sender:)), for: .touchUpInside)

        UIView.animate(withDuration: 3.0) {
            btn.alpha = 1.0
        }
    }
    @objc func btnClick(sender: UIButton) {
        print("进入应用")
        self.view.window?.rootViewController = RootViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

