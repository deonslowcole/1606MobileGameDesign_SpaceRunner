//
//  EnemyShips.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/19/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit


extension GameScene {
    
    //Method that creates the new enemy ships onto the scene
    func showEnemyShip1() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyShip1 = SKSpriteNode(texture: spriteSheet.enemyShip1())
        enemyShip1.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyShip1.name = "enemyShip1"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyShip1.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyShip1().size())
        enemyShip1.physicsBody?.dynamic = false
        enemyShip1.physicsBody?.allowsRotation = false
        enemyShip1.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship 1
        enemyShip1.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyShip1.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyShip1.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyShip1.anchorPoint.x
        shootEnemyLaser().position.y = enemyShip1.position.y - 300
        
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //Add the laser to the enemy ship
        enemyShip1.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //Add the enemy ship to the scene
        allObjects.addChild(enemyShip1)
    }
    
    
    
    func showEnemyShip2() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyShip2 = SKSpriteNode(texture: spriteSheet.enemyShip2())
        enemyShip2.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyShip2.name = "enemyShip2"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyShip2.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyShip2().size())
        enemyShip2.physicsBody?.dynamic = false
        enemyShip2.physicsBody?.allowsRotation = false
        enemyShip2.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship 1
        enemyShip2.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyShip2.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyShip2.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyShip2.anchorPoint.x
        shootEnemyLaser().position.y = enemyShip2.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyFired = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyFired)
        
        //add the enemy laser to the ship
        enemyShip2.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyShip2)
    }
    
    
    func showEnemyShip3() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyShip3 = SKSpriteNode(texture:spriteSheet.enemyShip3())
        enemyShip3.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyShip3.name = "enemyShip3"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyShip3.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyShip3().size())
        enemyShip3.physicsBody?.dynamic = false
        enemyShip3.physicsBody?.allowsRotation = false
        enemyShip3.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship 1
        enemyShip3.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyShip3.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyShip3.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyShip3.anchorPoint.x
        shootEnemyLaser().position.y = enemyShip3.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //add the enemy laser to the ship
        enemyShip3.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyShip3)
    }
    
    
    //Method to create and return the node for the enemy lasers. This can be used to add to the ememy ships.
    func shootEnemyLaser() -> SKSpriteNode {
        
        //Create a texture for the sprite and set it to the sprite node
        enemyLaser = SKSpriteNode(texture: spriteSheet.laserBlue())
        
        //Set the z position so that the sprite is behind the enemy ship
        enemyLaser.zPosition = -0.5
        
        //Create the physics body for the enemy ship's laser
        enemyLaser.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.laserBlue().size())
        enemyLaser.physicsBody?.dynamic = true
        
        //Set the mask to detect the types of collisions for the player ship's laser
        enemyLaser.physicsBody?.categoryBitMask = CollisionType.EnemyLaser.rawValue
        enemyLaser.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        enemyLaser.physicsBody?.collisionBitMask = 0
        
        return enemyLaser
        
    }
    
    
}
