//
//  GKMovingGround.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 13/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

let NUMBER_OF_SEGMENTS = 20
let COLOR_ONE: UIColor = UIColor(red: 88/255, green: 148/255, blue: 87/255, alpha: 1)
let COLOR_TWO: UIColor = UIColor(red: 120/255, green: 195/255, blue: 118/255, alpha: 1)

class GKMovingGround: SKSpriteNode {
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSize(width: size.width, height: size.height))
        //Assigning Anchor to (0,height/2)
        anchorPoint = CGPoint(x: 0, y: 0.5)
        
        var segmentColor: UIColor!
        
        for i in 0 ..< NUMBER_OF_SEGMENTS {
            
            if i%2 == 0 {
                segmentColor = COLOR_ONE
            }
            else {
                segmentColor = COLOR_TWO
            }
            
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: size.width/CGFloat(NUMBER_OF_SEGMENTS), height: size.height))
            segment.anchorPoint = CGPoint(x: 0,y: 0.5)
            segment.position = CGPoint(x: CGFloat(i) * segment.size.width, y: 0)
            
            addChild(segment)
        }
    }
    
    func start() {
        //Moves ground left by one whole screen
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: 1.0)
        
        //Teleports ground back to initial position
        let resetPosition = SKAction.moveToX(0, duration: 0)
        
        //Creates a sequence that combines above to actions
        let mySequence = SKAction.sequence([moveLeft,resetPosition])
        
        //Runs the sequence forever
        runAction(SKAction.repeatActionForever(mySequence))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
