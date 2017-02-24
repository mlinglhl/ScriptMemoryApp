//
//  SampleCharacter.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-24.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SampleCharacter: NSObject {
    let name: String
    var cards: [SampleCard]
    let script: SampleScript
    
    init(_ name: String, script: SampleScript) {
        self.name = name
        self.cards = [SampleCard]()
        self.script = script
    }
    
}
