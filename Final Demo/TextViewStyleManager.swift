//
//  TextViewStyleManager.swift
//  Final Demo
//
//  Created by Tristan Wolf on 2017-03-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import Foundation
import UIKit

public class TextViewStyleManager: UITextView {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 8.0
    }
}
