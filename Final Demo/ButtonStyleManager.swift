//
//  ButtonStyleManager.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-02.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import UIKit

public class ButtonStyleManager: UIButton {
    
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        
        
    }
    
}
