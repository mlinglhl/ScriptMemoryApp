//
//  CollapsibleTableViewHeader.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-22.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}


class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //
        // Constraint the size of arrow label for auto layout
        //
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor(hex: 0x2E3944)
        
        titleLabel.textColor = UIColor.white
        arrowLabel.textColor = UIColor.white
        
        //
        // Autolayout the lables
        //
//        let views = [
//            "titleLabel" : titleLabel,
//            "arrowLabel" : arrowLabel,
//            ]
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: arrowLabel.leadingAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        arrowLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
//            options: [],
//            metrics: nil,
//            views: views
//        ))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-[titleLabel]-|",
//            options: [],
//            metrics: nil,
//            views: views
//        ))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-[arrowLabel]-|",
//            options: [],
//            metrics: nil,
//            views: views
//        ))
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowLabel.rotate(collapsed ? 0.0 : CGFloat(M_PI_2))
    }
}
