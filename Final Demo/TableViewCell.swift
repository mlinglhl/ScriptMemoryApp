//
//  TableViewCell.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0).cgColor,UIColor(red:0.47, green:0.09, blue:0.12, alpha:1.0).cgColor, UIColor(red:0.29, green:0.13, blue:0.45, alpha:1.0).cgColor]
        
        
        newLayer.frame = self.frame
        
        self.layer.addSublayer(newLayer)
        
        self.layer.insertSublayer(newLayer, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
