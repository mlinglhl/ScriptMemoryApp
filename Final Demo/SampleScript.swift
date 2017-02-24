//
//  SampleScript.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SampleScript: NSObject {
    let name: String
    var characters: [SampleCharacter]
    
    init(_ name: String) {
        self.name = name
        self.characters = [SampleCharacter]()
    }
}
