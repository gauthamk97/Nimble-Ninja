//
//  GKWallGenerator.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 15/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

class GKWallGenerator: SKSpriteNode {
    
    var generationTimer: NSTimer!
    var allWalls = [GKWall]()
    
    func generateWalls() {
        let x = self.frame.width/2
        let y: CGFloat
        if arc4random_uniform(UInt32(2)) == 0 {
            y = kGKMovingGround/2 + WALL_HEIGHT/2
        }
        else {
            y = -kGKMovingGround/2 - WALL_HEIGHT/2
        }
        
        let newWall = GKWall(size: CGSizeMake(WALL_WIDTH, WALL_HEIGHT))
        newWall.position = CGPointMake(x, y)
        addChild(newWall)
        allWalls.append(newWall)
        
        
    }
    
    func startGeneratingMoreWalls(spawnTime: NSTimeInterval) {
        
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(spawnTime, target: self, selector: #selector(GKWallGenerator.generateWalls), userInfo: nil, repeats: true)
        
    }
    
    func onCollision() {
        stopGeneratingMoreWalls()
        for wall in allWalls {
            wall.stopMoving()
        }
    }
    
    func stopGeneratingMoreWalls() {
        generationTimer.invalidate()
    }
    
}
