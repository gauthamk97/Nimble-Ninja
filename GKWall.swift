//
//  GKWall.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 15/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

class GKWall: SKSpriteNode {
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.blackColor(), size: CGSizeMake(size.width, size.height))
        anchorPoint = CGPointMake(0, 0)
        
        startMoving()
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-kDefaultXtoMovePerSecond, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
