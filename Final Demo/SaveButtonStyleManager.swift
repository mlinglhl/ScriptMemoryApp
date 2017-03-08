//
//  SaveButtonStyleManager.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-02.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import UIKit

public class SaveButtonStyleManager: UIButton {
    
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
