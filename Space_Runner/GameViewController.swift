//
//  GameViewController.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/2/16.
//  Copyright (c) 2016 Deon Cole. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let apiKey = "4c18bcc27974477ec47e3b30464e1ac3bdf4d7e8ea67e6003b373d9dcf2833cf"
    let secretKey = "c5e98434acc66785c44109d1021015a758fd9428f54e07c02d79732c29e47eb6"

    var storageService = App42API.buildStorageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initalize the API for BaaS
        App42API.initializeWithAPIKey(apiKey, andSecretKey: secretKey)
        App42API.enableApp42Trace(true)
        
        
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true

            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
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
