//
//  CardManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-20.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class CardManager: NSObject {
    var cardArray = [Card]()

    static let sharedInstance = CardManager()
    private override init() {}
}
