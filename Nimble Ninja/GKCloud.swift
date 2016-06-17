//
//  GKCloud.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 15/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

class GKCloud: SKShapeNode {
    
    init(size: CGSize) {
        super.init()
        let path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, size.width, size.height), nil)
        self.path = path
        fillColor = UIColor.whiteColor()
        
        startMoving()
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-10, y: 0, duration: 1)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    
    func stopMoving() {
        removeAllActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
