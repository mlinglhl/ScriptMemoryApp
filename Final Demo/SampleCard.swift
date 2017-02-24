//
//  SampleCard.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-18.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class SampleCard: NSObject {
    let question: String
    let answer: String
    let character: SampleCharacter
    
    init(question: String, answer: String, character: SampleCharacter) {
        self.question = question
        self.answer = answer
        self.character = character
    }
}
