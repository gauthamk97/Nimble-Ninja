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
var pointsLabel: GKPointsLabel!
var highscoreLabel: GKPointsLabel!

let myDefaults = NSUserDefaults.standardUserDefaults()

var firstClick: Bool = true
var isGameOver: Bool = false
var wallNumberForPoints: Int = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Clean slating
        wallNumberForPoints = 0
        kWallGenerationTime = 0.75
        LevelNumber = 0
        kDefaultXtoMovePerSecond = 400
        
        //Assigning sky background color
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1)
        
        //Creating the Clouds
        cloudGenerator = GKCloudGenerator(texture: nil, color: UIColor.clearColor(), size: view.frame.size)
        cloudGenerator.position = view.center
        addChild(cloudGenerator)
        cloudGenerator.populate(7)
        cloudGenerator.startGeneratingMoreClouds(10)
        
        //Creating the ground
        movingGround = GKMovingGround(size: CGSize(width: view.frame.width*10, height: kGKMovingGround))
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
        tapToStartLabel.runAction(blinkAnimation())
        
        //Adding word 'point' and 'highscore'
        let pointsWordLabel = SKLabelNode(text: "Points")
        pointsWordLabel.position = CGPointMake(50, view.frame.size.height-40)
        //pointsWordLabel.fontName = "San Fransisco"
        pointsWordLabel.fontColor = UIColor.blackColor()
        addChild(pointsWordLabel)
        
        let highscoreWordLabel = SKLabelNode(text: "High Score")
        highscoreWordLabel.position = CGPointMake(view.frame.size.width-80, view.frame.size.height-40)
        //highscoreWordLabel.fontName = "San Fransisco"
        highscoreWordLabel.fontColor = UIColor.blackColor()
        addChild(highscoreWordLabel)
        
        //Adding points and highscore label
        pointsLabel = GKPointsLabel(num: 0)
        pointsLabel.position = CGPointMake(0, -30)
        pointsWordLabel.addChild(pointsLabel)
        
        highscoreLabel = GKPointsLabel(num: 0)
        highscoreLabel.position = CGPointMake(0, -30)
        highscoreLabel.number = myDefaults.integerForKey("highscore")
        highscoreLabel.text = "\(highscoreLabel.number)"
        highscoreWordLabel.addChild(highscoreLabel)
        
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
            wallGenerator.startGeneratingMoreWalls(kWallGenerationTime)
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
        
        if CGRectGetMaxX(movingGround.frame) < CGRectGetMaxX((view?.frame)!) {
            
            let resetPosition = SKAction.moveByX(movingGround.frame.size.width/2, y: 0, duration: 0)
            
            movingGround.runAction(resetPosition)
        }
        
        if wallGenerator.allWalls.count > 0 {
            
            let firstWall = wallGenerator.allWalls[wallNumberForPoints]
            
            let wallLocation = wallGenerator.convertPoint(firstWall.position, toNode: self)
            
            if wallLocation.x < hero.position.x-32 {
                pointsLabel.increment()
                wallNumberForPoints += 1
                
                if pointsLabel.number % 5 == 0 && LevelNumber < 4 {
                    LevelNumber += 1
                    kWallGenerationTime = LevelTimes[LevelNumber]
                    kDefaultXtoMovePerSecond += 50
                    movingGround.stop()
                    movingGround.start()
                    
                    wallGenerator.allWalls[pointsLabel.number+1].stopMoving()
                    wallGenerator.allWalls[pointsLabel.number+1].startMoving()
                    wallGenerator.allWalls[pointsLabel.number].stopMoving()
                    wallGenerator.allWalls[pointsLabel.number].startMoving()
                    
                    wallGenerator.stopGeneratingMoreWalls()
                    wallGenerator.startGeneratingMoreWalls(kWallGenerationTime)
                
                }
                
            }
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        isGameOver = true
        firstClick = true

        print("Contact occured")
        
        //Stopping everything
        hero.fall()
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
        gameOverLabel.runAction(blinkAnimation())
        
        //Checking for highscore. Saving if necessary
        if pointsLabel.number > highscoreLabel.number {
            highscoreLabel.text = "\(pointsLabel.number)"
            highscoreLabel.number = pointsLabel.number
            myDefaults.setInteger(highscoreLabel.number, forKey: "highscore")
        }
    }
    
    func blinkAnimation() -> SKAction {
        
        let fadeOut = SKAction.fadeAlphaTo(0, duration: 0.6)
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 0.6)
        
        let blink = SKAction.repeatActionForever(SKAction.sequence([fadeOut,fadeIn]))
        return blink
    }
    
    func restart() {
        //Creating the new scene
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        view!.presentScene(newScene)
        isGameOver = false
    }
}
