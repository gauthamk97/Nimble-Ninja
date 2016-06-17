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
var cloudGenerator: GKCloudGenerator!
var wallGenerator: GKWallGenerator!

var firstClick: Bool = true
var isGameOver: Bool = false

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //Assigning sky background color
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1)
        
        //Creating the Clouds
        cloudGenerator = GKCloudGenerator(texture: nil, color: UIColor.clearColor(), size: view.frame.size)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
        cloudGenerator.startGeneratingMoreClouds(10)
        
        //Creating the ground
        movingGround = GKMovingGround(size: CGSize(width: view.frame.width*2, height: kGKMovingGround))
        movingGround.position = CGPoint(x: 0, y: view.center.y)
        addChild(movingGround)
        
        //Creating the walls
        wallGenerator = GKWallGenerator(texture: nil, color: UIColor.clearColor(), size: view.frame.size)
        wallGenerator.position = view.center
        addChild(wallGenerator)
        
        //Creating the hero
        hero = GKHero()
        hero.position = CGPoint(x: 70, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        addChild(hero)
        hero.breathe()
        
        //Adding Start Label
        let tapToStartLabel = SKLabelNode(text: "Tap to Start!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position = CGPointMake(view.center.x, view.center.y + 75)
        tapToStartLabel.fontColor = UIColor.blackColor()
        tapToStartLabel.fontSize = 22
        tapToStartLabel.fontName = "Helvetica"
        addChild(tapToStartLabel)
        
        //Creating the physics world
        physicsWorld.contactDelegate = self
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        if isGameOver {
            restart()
        }
            
        else if firstClick {
            hero.stopBodyActions()
            hero.startRunning()
            movingGround.start()
            wallGenerator.startGeneratingMoreWalls(0.75)
            let tapToStartLabel = childNodeWithName("tapToStartLabel")
            tapToStartLabel?.removeFromParent()
            firstClick = false
        }
        
        else {
            hero.flip()
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        isGameOver = true
        firstClick = true
        
        print("Contact occured")
        
        //Stopping everything
        wallGenerator.onCollision()
        cloudGenerator.onCollision()
        movingGround.stop()
        hero.stopAllActions()
        
        //Creating the GameOver Label
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.position = CGPointMake(view!.center.x, view!.center.y + 75)
        gameOverLabel.fontColor = UIColor.blackColor()
        gameOverLabel.fontSize = 22
        gameOverLabel.fontName = "Helvetica"
        addChild(gameOverLabel)
    }
    
    func restart() {
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        view!.presentScene(newScene)
        isGameOver = false
    }
}
