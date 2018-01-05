//
//  MoiveViewController.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2017/12/20.
//  Copyright © 2017年 李文静. All rights reserved.
//

import UIKit
import AVKit

class MovieViewController: UIViewController {

    var playerView:AVPlayerViewController?
    var player: AVPlayer?
    var movieUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let player = AVPlayer(url: movieUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        self.setupLoginView()
        
    }

    func setupLoginView(){
        let btn = UIButton.init(frame: CGRect(x: 24, y: UIScreen.main.bounds.size.height - 32-48, width: UIScreen.main.bounds.size.width-48, height: 48))
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 24
        btn.layer.borderColor = UIColor.white.cgColor
        btn.setTitle("进入应用", for: .normal)
        btn.alpha = 0
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(MovieViewController.btnClick(sender:)), for: .touchUpInside)
        UIView.animate(withDuration: 3.0) {
            btn.alpha = 1.0
        }
    }
    
    @objc func btnClick(sender: UIButton) {
//        let vc =  DrawerViewController.drawerWithOpenViewController(leftVC: LeftViewController.init(), mainVC: MainViewController.init(), drawerMaxWidth: 100)
        let vc = MainViewController()
        let navVc = BaseNavigationController.init(rootViewController: vc)
        self.view.window?.rootViewController = vc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
