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
    
        //kDefaultXtoMovePerSecond += 4
        
        startMoving()
        loadPhysicsBodyWithSize(CGSizeMake(WALL_WIDTH, WALL_HEIGHT))
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-kDefaultXtoMovePerSecond, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
