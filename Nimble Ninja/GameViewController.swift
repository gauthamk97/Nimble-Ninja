//
//  GameViewController.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 12/06/16.
//  Copyright (c) 2016 Gautham Kumar. All rights reserved.
//

import UIKit
import SpriteKit

var scene: GameScene!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Configure the view
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        //Present the scene
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
