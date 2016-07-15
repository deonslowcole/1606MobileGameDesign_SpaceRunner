//
//  Meteors.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/19/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func moveMeteors() -> SKAction {
        
        let showMeteor = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 300))
        let removeMeteor = SKAction.removeFromParent()
        let showAndRemoveMeteor = SKAction.sequence([showMeteor, removeMeteor])
        
        return showAndRemoveMeteor
        
    }
    
    //MARK: Meteors
    
    func createMeteor1 () {
        
        meteor1 = SKSpriteNode(texture: spriteSheet.meteor1())
        meteor1.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor1.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor1().size())
        meteor1.name = "Meteor"
        meteor1.physicsBody?.dynamic = false
        meteor1.physicsBody?.allowsRotation = true
        
        meteor1.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor1.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor1.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor1.runAction(moveMeteors())
        allObjects.addChild(meteor1)
        
    }
    
    
    func createMeteor2 () {
        
        meteor2 = SKSpriteNode(texture: spriteSheet.meteor2())
        meteor2.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor2.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor2().size())
        meteor2.name = "Meteor"
        meteor2.physicsBody?.dynamic = false
        meteor2.physicsBody?.allowsRotation = true
        
        meteor2.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor2.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor2.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor2.runAction(moveMeteors())
        allObjects.addChild(meteor2)
        
    }
    
    func createMeteor3 () {
        
        meteor3 = SKSpriteNode(texture: spriteSheet.meteor3())
        meteor3.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor3.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor3().size())
        meteor3.name = "Meteor"
        meteor3.physicsBody?.dynamic = false
        meteor3.physicsBody?.allowsRotation = true
        
        meteor3.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor3.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor3.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor3.runAction(moveMeteors())
        allObjects.addChild(meteor3)
        
    }
    
    func createMeteor4 () {
        
        meteor4 = SKSpriteNode(texture: spriteSheet.meteor4())
        meteor4.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor4.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor4().size())
        meteor4.name = "Meteor"
        meteor4.physicsBody?.dynamic = false
        meteor4.physicsBody?.allowsRotation = true
        
        meteor4.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor4.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor4.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor4.runAction(moveMeteors())
        self.addChild(meteor4)
        
    }
    
    
    func createMeteor5 () {
        
        meteor5 = SKSpriteNode(texture: spriteSheet.meteor5())
        meteor5.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor5.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor5().size())
        meteor5.name = "Meteor"
        meteor5.physicsBody?.dynamic = false
        meteor5.physicsBody?.allowsRotation = true
        
        meteor5.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor5.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor5.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor5.runAction(moveMeteors())
        allObjects.addChild(meteor5)
        
    }
    
    
    func createMeteor6 () {
        
        meteor6 = SKSpriteNode(texture: spriteSheet.meteor6())
        meteor6.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor6.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor6().size())
        meteor6.name = "Meteor"
        meteor6.physicsBody?.dynamic = false
        meteor6.physicsBody?.allowsRotation = true
        
        meteor6.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor6.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor6.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor6.runAction(moveMeteors())
        allObjects.addChild(meteor6)
    }
    
    func createMeteor7 () {
        
        meteor7 = SKSpriteNode(texture: spriteSheet.meteor7())
        meteor7.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor7.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor7().size())
        meteor7.name = "Meteor"
        meteor7.physicsBody?.dynamic = false
        meteor7.physicsBody?.allowsRotation = true
        
        meteor7.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor7.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor7.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor7.runAction(moveMeteors())
        allObjects.addChild(meteor7)
    }
    
    func createMeteor8 () {
        
        meteor8 = SKSpriteNode(texture: spriteSheet.meteor8())
        meteor8.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor8.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor8().size())
        meteor8.name = "Meteor"
        meteor8.physicsBody?.dynamic = false
        meteor8.physicsBody?.allowsRotation = true
        
        meteor8.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        meteor8.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        meteor8.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        meteor8.runAction(moveMeteors())
        allObjects.addChild(meteor8)
    }
    
}


