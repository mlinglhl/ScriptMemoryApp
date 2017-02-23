//
//  TableViewDataManager.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-23.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

struct Section {
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

class TableViewDataManager: NSObject, UITableViewDataSource {
    var scriptSection: [Section]
    var artistSection: [Section]
    var activeSection: [Section]
    let scriptArray: [String]
    let artistArray: [String]
    var activeArray = [String]()
    var dataArray = [[Double]]()
    
    override init() {
        scriptArray = ["Avenue Q", "Les Miserables", "King Lear", "Lucky Stiff", "Hamlet", "Legally Blonde"]
        artistArray = ["Thriller", "Back in Black", "The Dark Side of the Moon", "The Bodyguard", "Bat Out of Hell"]
        artistSection = [Section(name: artistArray[0], items: artistArray),
                        Section(name: artistArray[0], items: artistArray)]
        scriptSection = [Section(name: scriptArray[0], items: scriptArray),
                         Section(name: scriptArray[0], items: scriptArray)]
        activeSection = scriptSection
        activeArray = scriptArray
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return activeSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeSection[section].items.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = activeSection[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    func changeType(_ type: String) {
        switch type {
        case "Script":
            activeArray = scriptArray
            activeSection = scriptSection
            break
        case "Artist":
            activeArray = artistArray
            activeSection = artistSection
            break
        default:
            break
        }

    }
    
}
