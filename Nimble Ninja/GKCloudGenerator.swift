//
//  GKCloudGenerator.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 15/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

class GKCloudGenerator: SKSpriteNode {
    
    var generationTimer: NSTimer!
    
    func populate(num: Int) {
        for _ in 1 ... num {
            let Cloud = GKCloud(size: CGSizeMake(CLOUD_WIDTH, CLOUD_HEIGHT))
            let CloudXPosition = CGFloat(arc4random_uniform(UInt32(size.width - CLOUD_WIDTH))) - (size.width/2 - CLOUD_WIDTH/2)
            let CloudYPosition = CGFloat(arc4random_uniform(UInt32(size.height - CLOUD_HEIGHT))) - (size.height/2 - CLOUD_HEIGHT/2)
            Cloud.position = CGPointMake(CloudXPosition, CloudYPosition)
            addChild(Cloud)
        }
    }
    
    func generateClouds() {
        
        let x = size.width/2 + CLOUD_WIDTH/2
        let y = CGFloat(arc4random_uniform(UInt32(size.height - CLOUD_HEIGHT))) - (size.height/2 - CLOUD_HEIGHT/2)
        let newCloud = GKCloud(size: CGSizeMake(CLOUD_WIDTH, CLOUD_HEIGHT))
        newCloud.position = CGPointMake(x, y)
        addChild(newCloud)
        
    }
    
    func startGeneratingMoreClouds(spawnTime: NSTimeInterval) {
        
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(spawnTime, target: self, selector: #selector(GKCloudGenerator.generateClouds), userInfo: nil, repeats: true)
    }
    
}
