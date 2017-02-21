//
//  Manager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class Manager: NSObject {
    
    var character: String?
    
    static let sharedInstance = Manager()
    private override init() {
    }
}
