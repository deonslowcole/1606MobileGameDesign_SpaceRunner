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
    var enemyShip1: SKSpriteNode?
    var fireButton: SKSpriteNode?
    var powerUpShield: SKSpriteNode?
    var leftButton: SKSpriteNode?
    
    var playerLaser: SKAudioNode?
    var playerShield: SKAudioNode?
    
//    var playerShip = SKSpriteNode(imageNamed: "playerShipRed.png")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        playerShip = self.childNodeWithName("playerShip") as? SKSpriteNode
//        enemyShip1 = self.childNodeWithName("enemyShipBlack1") as? SKSpriteNode
        leftButton = self.childNodeWithName("moveLeftButton") as? SKSpriteNode
        
        let rain = SKEmitterNode(fileNamed: "Rain.sks")
        rain?.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        self.addChild(rain!)
        
        
        //Add a left bound to the scene so the players ship doesn't go off the screen. Declare a constant as a SKNode. Set the starting position of the left bound to the bottom left corner. Make the bound a rectangle with the x size to .0 and the height equal to the size of the frame. Add it to the scene. Repeat for the right bound
        let leftBound = SKNode()
        leftBound.position = CGPointMake(0, 0)
        leftBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.5, self.size.height))
        leftBound.physicsBody?.dynamic = false
        self.addChild(leftBound)
        
        let rightBound = SKNode()
        rightBound.position = CGPointMake(1080, 0)
        rightBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.5, self.size.height))
        rightBound.physicsBody?.dynamic = false
        self.addChild(rightBound)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            //Declare a constant to hold the location of the touch
            let location = touch.locationInNode(self)
            
            //Declare a constant to hold the node that is touched at the location
            let touchedNode = self.nodeAtPoint(location)
            
            print(touchedNode)
            
            //Use a if conditional to check the name of the touched node. Run the sound effect if the name of the touch node is found.
            if let name = touchedNode.name {
                
                if name == "fireButton" {
                    runAction(SKAction.playSoundFileNamed("PlayerLaserShot.mp3", waitForCompletion: false))
                } else if name == "powerUpShield" {
                    runAction(SKAction.playSoundFileNamed("powerUpShield.mp3", waitForCompletion: false))
                } else if name == "moveLeftButton" {
                    playerShip?.physicsBody?.velocity = CGVectorMake(-500, 0)
                } else if name == "moveRightButton" {
                    playerShip?.physicsBody?.velocity = CGVectorMake(500, 0)
                }
            }
            
        }
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
    }
    
    
    
    
    
}
