//
//  GKPointsLabel.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 17/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GKPointsLabel: SKLabelNode {
    
    var number = 0
    
    init(num: Int) {
        super.init()
        
        //fontName = "Helvetica"
        fontColor = UIColor.blackColor()
        fontSize = 24
        
        number = num
        text = "\(number)"
    }
    
    func increment() {
        number += 1
        text = "\(number)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
