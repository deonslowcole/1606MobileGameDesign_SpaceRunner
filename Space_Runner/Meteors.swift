//
//  Meteors.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/19/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    //MARK: Meteors
    
    func createMetor1 () {
        
        meteor1 = SKSpriteNode(texture: spriteSheet.meteor1())
        meteor1.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor1.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor1().size())
        meteor1.name = "Meteor"
        meteor1.physicsBody?.dynamic = false
        meteor1.physicsBody?.allowsRotation = true
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        meteor1.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor1.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor1.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor1.runAction(showAndRemoveMeteor)
        allObjects.addChild(meteor1)
        
    }
    
    
    func createMetor2 () {
        
        meteor2 = SKSpriteNode(texture: spriteSheet.meteor2())
        meteor2.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor2.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor2().size())
        meteor2.name = "Meteor"
        meteor2.physicsBody?.dynamic = false
        meteor2.physicsBody?.allowsRotation = true
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        meteor2.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor2.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor2.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor2.runAction(showAndRemoveMeteor)
        allObjects.addChild(meteor2)
        
    }
    
    func createMetor3 () {
        
        meteor3 = SKSpriteNode(texture: spriteSheet.meteor3())
        meteor3.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor3.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor3().size())
        meteor3.name = "Meteor"
        meteor3.physicsBody?.dynamic = false
        meteor3.physicsBody?.allowsRotation = true
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        meteor3.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor3.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor3.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor3.runAction(showAndRemoveMeteor)
        allObjects.addChild(meteor3)
        
    }
    
    func createMetor4 () {
        
        meteor4 = SKSpriteNode(texture: spriteSheet.meteor4())
        meteor4.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor4.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor4().size())
        meteor4.name = "Meteor"
        meteor4.physicsBody?.dynamic = false
        meteor4.physicsBody?.allowsRotation = true
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        meteor4.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor4.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor4.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor4.runAction(showAndRemoveMeteor)
        self.addChild(meteor4)
        
    }
    
    
    func createMetor5 () {
        
        meteor5 = SKSpriteNode(texture: spriteSheet.meteor5())
        meteor5.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor5.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor5().size())
        meteor5.name = "Meteor"
        meteor5.physicsBody?.dynamic = false
        meteor5.physicsBody?.allowsRotation = true
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        meteor5.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor5.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor5.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor5.runAction(showAndRemoveMeteor)
        allObjects.addChild(meteor5)
        
    }
    
    
}


