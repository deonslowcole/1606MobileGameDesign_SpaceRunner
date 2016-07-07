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
    func showEnemyShipBlack1() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyBlack1 = SKSpriteNode(texture: spriteSheet.enemyBlack1())
        enemyBlack1.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyBlack1.name = "enemyShipBlack1"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyBlack1.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyBlack1().size())
        enemyBlack1.physicsBody?.dynamic = false
        enemyBlack1.physicsBody?.allowsRotation = false
        enemyBlack1.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship
        enemyBlack1.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyBlack1.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyBlack1.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyBlack1.anchorPoint.x
        shootEnemyLaser().position.y = enemyBlack1.position.y - 300
        
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //Add the laser to the enemy ship
        enemyBlack1.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //Add the enemy ship to the scene
        allObjects.addChild(enemyBlack1)
    }
    
    
    
    func showEnemyShipBlack2() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyBlack2 = SKSpriteNode(texture: spriteSheet.enemyBlack2())
        enemyBlack2.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyBlack2.name = "enemyShipBlack2"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyBlack2.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyBlack2().size())
        enemyBlack2.physicsBody?.dynamic = false
        enemyBlack2.physicsBody?.allowsRotation = false
        enemyBlack2.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship
        enemyBlack2.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyBlack2.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyBlack2.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyBlack2.anchorPoint.x
        shootEnemyLaser().position.y = enemyBlack2.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyFired = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyFired)
        
        //add the enemy laser to the ship
        enemyBlack2.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyBlack2)
    }
    
    
    func showEnemyShipBlack3() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyBlack3 = SKSpriteNode(texture:spriteSheet.enemyBlack3())
        enemyBlack3.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyBlack3.name = "enemyShipBlack3"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyBlack3.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyBlack3().size())
        enemyBlack3.physicsBody?.dynamic = false
        enemyBlack3.physicsBody?.allowsRotation = false
        enemyBlack3.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship
        enemyBlack3.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyBlack3.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyBlack3.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyBlack3.anchorPoint.x
        shootEnemyLaser().position.y = enemyBlack3.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //add the enemy laser to the ship
        enemyBlack3.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyBlack3)
    }
    
    func showEnemyShipBlack4() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyBlack4 = SKSpriteNode(texture:spriteSheet.enemyBlack4())
        enemyBlack4.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyBlack4.name = "enemyShipBlack4"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyBlack4.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyBlack4().size())
        enemyBlack4.physicsBody?.dynamic = false
        enemyBlack4.physicsBody?.allowsRotation = false
        enemyBlack4.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship
        enemyBlack4.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyBlack4.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyBlack4.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyBlack4.anchorPoint.x
        shootEnemyLaser().position.y = enemyBlack4.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //add the enemy laser to the ship
        enemyBlack4.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyBlack4)
    }
    
    func showEnemyShipBlack5() {
        
        //Declare a constant to hold the texture and set it to the node. Set the position of the ship outside of the frame plus 200 as a starting point
        enemyBlack5 = SKSpriteNode(texture:spriteSheet.enemyBlack5())
        enemyBlack5.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame) + 200)
        enemyBlack5.name = "enemyShipBlack5"
        
        
        //Declare constants for moving the enemy ship. Start it out of frame at the top of the screen and move it downwards in the timeframe of the size of the frame divided by 200. Once it is out of frame remove it from the parent. Use a SKAction sequence to run both actions
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        
        //Set the phyics body of the enemy ship 1
        enemyBlack5.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.enemyBlack5().size())
        enemyBlack5.physicsBody?.dynamic = false
        enemyBlack5.physicsBody?.allowsRotation = false
        enemyBlack5.runAction(showAndRemoveEnemy)
        
        //Set the mask to detect the types of collisions for the enemy ship
        enemyBlack5.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyBlack5.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyBlack5.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        //Set the position of the sprite equal to the anchor point of the enemy ship and set the height and width.
        shootEnemyLaser().position.x = enemyBlack5.anchorPoint.x
        shootEnemyLaser().position.y = enemyBlack5.position.y - 300
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let enemyShot = SKAction.moveToY(-self.size.height, duration: 2)
        shootEnemyLaser().runAction(enemyShot)
        
        //add the enemy laser to the ship
        enemyBlack5.addChild(shootEnemyLaser())
        runAction(enemyLaserAudio)
        
        //add the enemy ship to the scene
        allObjects.addChild(enemyBlack5)
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
