//
//  GKHero.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 13/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import SpriteKit

class GKHero: SKSpriteNode {
    
    var body: SKSpriteNode!
    var face: SKSpriteNode!
    var arm: SKSpriteNode!
    var hand: SKSpriteNode!
    var leftEye: SKSpriteNode!
    var rightEye: SKSpriteNode!
    var pupil: SKSpriteNode!
    var eyebrow: SKSpriteNode!
    var leftFoot: SKSpriteNode!
    var rightFoot: SKSpriteNode!
    
    var isUpsideDown: Bool = false
    
    init() {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 44))
        
        //Creating the body
        body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(self.size.width, 40))
        body.position = CGPoint(x: 0, y: 2)
        addChild(body)
        
        //Creating the face
        let skinColor = UIColor(red: 207/255, green: 193/255, blue: 168/255, alpha: 1)
        face = SKSpriteNode(color: skinColor, size: CGSizeMake(self.size.width, 12))
        face.position = CGPoint(x: 0, y: 6)
        addChild(face)
        
        //Creating the eyes and pupils
        let eyeColor = UIColor.whiteColor()
        leftEye = SKSpriteNode(color: eyeColor, size: CGSizeMake(6, 6))
        rightEye = leftEye.copy() as! SKSpriteNode
        pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3, 3))
        
        leftEye.position = CGPointMake(-4, face.position.y)
        rightEye.position = CGPointMake(14, face.position.y)
        addChild(leftEye)
        addChild(rightEye)
        
        pupil.position = CGPointMake(2, 0)
        leftEye.addChild(pupil)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        
        //Creating the eyebrows
        eyebrow = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(11, 1))
        eyebrow.position = CGPointMake(-1, leftEye.frame.size.height/2)
        leftEye.addChild(eyebrow)
        rightEye.addChild(eyebrow.copy() as!  SKSpriteNode)
        
        //Creating the arm
        arm = SKSpriteNode(color: UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1), size: CGSizeMake(8, 14))
        arm.anchorPoint = CGPointMake(0.5, 0.9)
        arm.position = CGPointMake(-10, -7)
        body.addChild(arm)
        
        //Creating the hand
        hand = SKSpriteNode(color: skinColor, size: CGSizeMake(arm.size.width, 5))
        hand.position = CGPointMake(0, hand.frame.size.height/2 - arm.frame.size.height*0.9)
        arm.addChild(hand)
        
        //Creating the left foot
        leftFoot = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(9, 4))
        leftFoot.position = CGPointMake(-6, -size.height/2 + leftFoot.frame.size.height/2)
        addChild(leftFoot)
        
        //Creating the right foot
        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 8
        addChild(rightFoot)
        
        //Creating the physics body
        loadPhysicsBodyWithSize(CGSizeMake(32, 44))
    
    }
    
    func breathe() {
        let breathOut = SKAction.moveByX(0, y: -2, duration: 0.75)
        let breathIn = SKAction.moveByX(0, y: 2, duration: 0.75)
        let breath = SKAction.sequence([breathOut,breathIn])
        
        body.runAction(SKAction.repeatActionForever(breath))
    }
    
    func flip() {
        isUpsideDown = !isUpsideDown
        
        var scale: CGFloat!
        
        if isUpsideDown {
            scale = -1.0
        }
        else {
            scale = +1.0
        }
        
        let translate = SKAction.moveByX(0, y: scale * (size.height + kGKMovingGround) , duration: 0.1)
        let flip = SKAction.scaleYTo(scale, duration: 0.1)
        
        runAction(translate)
        runAction(flip)
        
    }
    
    func fall() {
        physicsBody?.affectedByGravity = true
        physicsBody?.applyImpulse(CGVectorMake(-5, 30))
        
        let rotateBack = SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.8)
        runAction(rotateBack)
    }
    
    func startRunning() {
        let rotateBack = SKAction.rotateByAngle(-CGFloat(M_PI)/2, duration: 0.1)
        arm.runAction(rotateBack)
        
        performRunningCycle()
        
    }
    
    func performRunningCycle() {
        
        let up = SKAction.moveByX(0, y: 2, duration: 0.05)
        let down = SKAction.moveByX(0, y: -2, duration: 0.05)
        
        leftFoot.runAction(up) { 
            self.leftFoot.runAction(down)
            self.rightFoot.runAction(up, completion: { 
                self.rightFoot.runAction(down)
                self.performRunningCycle()
            })
        }
    }
    
    func stopBodyActions() {
        body.removeAllActions()
    }
    
    func stopAllActions() {
        let rotateForward = SKAction.rotateByAngle(CGFloat(M_PI)/2, duration: 0.1)
        arm.runAction(rotateForward)
        leftFoot.removeAllActions()
        rightFoot.removeAllActions()
        leftFoot.position = CGPointMake(-6, -size.height/2 + leftFoot.frame.size.height/2)
        rightFoot.position = CGPointMake(8, -size.height/2 + rightFoot.frame.size.height/2)
    }
    
    func loadPhysicsBodyWithSize(size: CGSize) {
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = heroCategory
        physicsBody?.contactTestBitMask = wallCategory
        physicsBody?.affectedByGravity = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}