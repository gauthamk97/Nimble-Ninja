//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 12/06/16.
//  Copyright (c) 2016 Gautham Kumar. All rights reserved.
//

import SpriteKit

var movingGround : GKMovingGround!
var hero: GKHero!

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //Assigning sky background color
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1)
        
        //Creating the ground
        movingGround = GKMovingGround(size: CGSize(width: view.frame.width*2, height: 20))
        movingGround.position = CGPoint(x: 0, y: view.center.y)
        
        //Adding the ground
        addChild(movingGround)
        
        //Creating the hero
        hero = GKHero()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        movingGround.start()
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
