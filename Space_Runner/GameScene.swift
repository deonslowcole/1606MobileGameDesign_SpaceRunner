//
//  GameScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/2/16.
//  Copyright (c) 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var playerShip: SKSpriteNode?
    var fireButton: SKSpriteNode?
    var powerUpShield: SKSpriteNode?
    var playerLaser: SKAudioNode?
    var playerShield: SKAudioNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        playerShip = self.childNodeWithName("playerShip") as? SKSpriteNode
        
        playerLaser = SKAudioNode(fileNamed: "PlayerLaserShot.mp3")
        playerLaser?.autoplayLooped = false
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        let touch = touches.first
        let location = touch?.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location!)
        
        print(touchedNode)
        
        if let name = touchedNode.name {
            
            if name == "fireButton" {
                runAction(SKAction.playSoundFileNamed("PlayerLaserShot.mp3", waitForCompletion: false))
            } else if name == "powerUpShield" {
                runAction(SKAction.playSoundFileNamed("powerUpShield.mp3", waitForCompletion: false))
            }
        }
        
        
        self.listener = fireButton
        playerLaser = SKAudioNode(fileNamed: "PlayerLaserShot.mp3")
        fireButton?.addChild(playerLaser!)
        
        self.listener = playerShield
        playerShield = SKAudioNode(fileNamed: "powerUpShield.mp3")
     
    }
    
   
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
