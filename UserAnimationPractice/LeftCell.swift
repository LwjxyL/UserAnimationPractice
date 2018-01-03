//
//  LeftCell.swift
//  UserAnimationPractice
//
//  Created by 李旭阳 on 2018/1/2.
//  Copyright © 2018年 李文静. All rights reserved.
//

import UIKit

class LeftCell: UITableViewCell {

    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.init(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
