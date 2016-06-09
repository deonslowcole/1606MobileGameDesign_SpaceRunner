//
//  GameScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/2/16.
//  Copyright (c) 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var fireButton: SKSpriteNode?
    var powerUpShield: SKSpriteNode?
    var leftButton: SKSpriteNode?
    
    var playerShip = SKSpriteNode()
    var shield = SKSpriteNode()
    
    //Create nodes for enemy ships
    var enemyShip1 = SKSpriteNode()
    var enemyShip2 = SKSpriteNode()
    var enemyShip3 = SKSpriteNode()
    var enemyShip4 = SKSpriteNode()
    var enemyShip5 = SKSpriteNode()
    var enemyShip6 = SKSpriteNode()
    
    //Declare a variable to hold the array of enemy ship nodes
    var enemyShips = [SKSpriteNode]()
    
    
    //Create a enum for the collision detection
    enum CollisionType: UInt32 {
        
        case PlayerShip = 1
        case Object = 2
        case Laser = 4
        case PowerUps = 5
    }
    
    
    var spaceBackground = SKSpriteNode()
    var playerLaser = SKSpriteNode()
    
    
    //Declare contants for audio
    let playerLaserAudio = SKAction.playSoundFileNamed("PlayerLaserShot.mp3", waitForCompletion: true)
    let playerShield = SKAction.playSoundFileNamed("powerUpShield.mp3", waitForCompletion: true)
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        //Set the delegate equal to self
        self.physicsWorld.contactDelegate = self
        
        
        //Create texture for the background scene. Set the node equal to the texture and position it in the middle of the scene. Set the height and width equal to the full frame. Set the z position to the far back and add the background to the scene.
        let spaceBackgroundTexture = SKTexture(imageNamed: "SpaceBackground.png")
        spaceBackground = SKSpriteNode(texture: spaceBackgroundTexture)
        spaceBackground.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        spaceBackground.size.height = self.frame.height
        spaceBackground.size.width = self.frame.width
        spaceBackground.zPosition = -1.0
        self.addChild(spaceBackground)
        
        
        let playerShipTexture = SKTexture(imageNamed: "playerShipRed.png")
        playerShip = SKSpriteNode(texture: playerShipTexture)
//        playerShip.size.height = 130
//        playerShip.size.width = 154
        playerShip.position = CGPointMake(self.size.width/2, self.size.height/5)
        
        playerShip.physicsBody = SKPhysicsBody(rectangleOfSize: playerShipTexture.size())
        playerShip.physicsBody?.dynamic = true
        playerShip.physicsBody?.affectedByGravity = false
        playerShip.physicsBody?.allowsRotation = false

        playerShip.physicsBody?.categoryBitMask = CollisionType.PlayerShip.rawValue
        playerShip.physicsBody?.contactTestBitMask = CollisionType.Object.rawValue
        playerShip.physicsBody?.collisionBitMask = CollisionType.PlayerShip.rawValue
        
        self.addChild(playerShip)
        
        
//        //Call the method to create the enemy ship nodes
//        createEnemyNodes()
        
        
        //Declare a constant to hold the timer for displaying the enemy ships
        _ = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameScene.showEnemyShips), userInfo: nil, repeats: true)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(GameScene.createShield), userInfo: nil, repeats: true)
        
        
        //Create emmiter nodes to add effect/animation to the scene.
        let rain = SKEmitterNode(fileNamed: "Rain.sks")
        rain?.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        self.addChild(rain!)
        
        let fire = SKEmitterNode(fileNamed: "Fire.sks")
        playerShip.addChild(fire!)
        
        
        //Add a left bound to the scene so the players ship doesn't go off the screen. Declare a constant as a SKNode. Set the starting position of the left bound to the bottom left corner. Make the bound a rectangle with the x size to .0 and the height equal to the size of the frame. Add it to the scene. Repeat for the right bound
        let leftBound = SKNode()
        leftBound.position = CGPointMake(0, 0)
        leftBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, self.size.height))
        leftBound.physicsBody?.dynamic = false
        self.addChild(leftBound)
        
        let rightBound = SKNode()
        rightBound.position = CGPointMake(self.frame.width, 0)
        rightBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, self.size.height))
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
                    runAction(playerLaserAudio)
                    shootLaser()
                } else if name == "powerUpShield" {
                    runAction(playerShield)
                } else if name == "moveLeftButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(-800, 0)
                } else if name == "moveRightButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(800, 0)
                }
            }
            
        }
        
    }
    

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        playerShip.physicsBody?.velocity = CGVectorMake(0, 0)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        let minTime = 4.0
        let maxTime = 8.0
        let rangeTime = maxTime - minTime
        let actualTime = (arc4random() % UInt32(rangeTime)) + UInt32(minTime)
    
        let toPlayer = SKAction.moveToX(playerShip.position.x, duration: NSTimeInterval(actualTime))
        
        enemyShip1.runAction(toPlayer)
    
    }
    
    //Mark: Functions
    //Method calls for the laser to be shot when the player presses the fire button
    func shootLaser() {
        
        //Create a texture for the sprite and set it to the sprite node
        let playerLaserTexture = SKTexture(imageNamed: "laserRed.png")
        playerLaser = SKSpriteNode(texture: playerLaserTexture)
        
        //Set the z position so that the sprite is behind the players ship
        playerLaser.zPosition = -0.5
        
        //Set the position of the sprite equal to the anchor point of the player ship and set the height and width.
        playerLaser.position = (playerShip.anchorPoint)
//        playerLaser.size.height = 90
//        playerLaser.size.width = 15
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let shoot = SKAction.moveToY(self.size.height, duration: 0.5)
        playerLaser.runAction(shoot)
        
        playerLaser.physicsBody = SKPhysicsBody(rectangleOfSize: playerLaserTexture.size())
        playerLaser.physicsBody?.dynamic = true
        playerLaser.physicsBody?.affectedByGravity = false
        
        playerLaser.physicsBody?.categoryBitMask = CollisionType.Laser.rawValue
        playerLaser.physicsBody?.contactTestBitMask = CollisionType.Object.rawValue
        playerLaser.physicsBody?.collisionBitMask = CollisionType.PowerUps.rawValue
        
        
        //Add the laser to the player ship so that it will move as the player's ship moves
        playerShip.addChild(playerLaser)
        
    }
    
    //Method creates the enemy shop nodes and appends them to the enemy ships array
    func createEnemyNodes(){
        
        let enemyShip1Texture = SKTexture(imageNamed: "enemyShip1")
        enemyShip1 = SKSpriteNode(texture: enemyShip1Texture)
        enemyShip1.size.height = 130
        enemyShip1.size.width = 154
        enemyShips.append(enemyShip1)
        
        let enemyShip2Texture = SKTexture(imageNamed: "enemyShip2")
        enemyShip2 = SKSpriteNode(texture: enemyShip2Texture)
        enemyShip2.size.height = 130
        enemyShip2.size.width = 154
        enemyShips.append(enemyShip2)
        
        let enemyShip3Texture = SKTexture(imageNamed: "enemyShip3")
        enemyShip3 = SKSpriteNode(texture: enemyShip3Texture)
        enemyShip3.size.height = 130
        enemyShip3.size.width = 154
        enemyShips.append(enemyShip3)
        
        let enemyShip4Texture = SKTexture(imageNamed: "enemyShip4")
        enemyShip4 = SKSpriteNode(texture: enemyShip4Texture)
        enemyShip4.size.height = 130
        enemyShip4.size.width = 154
        enemyShips.append(enemyShip4)
        
        let enemyShip5Texture = SKTexture(imageNamed: "enemyShip5")
        enemyShip5 = SKSpriteNode(texture: enemyShip5Texture)
        enemyShip5.size.height = 130
        enemyShip5.size.width = 154
        enemyShips.append(enemyShip5)
        
        let enemyShip6Texture = SKTexture(imageNamed: "enemyShip6")
        enemyShip6 = SKSpriteNode(texture: enemyShip6Texture)
        enemyShip6.size.height = 130
        enemyShip6.size.width = 154
        enemyShips.append(enemyShip6)
        
    }
    
    //Method that creates the new enemy ships onto the scene
    func showEnemyShips() {
        
        let showEnemy = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 200))
        let removeEnemy = SKAction.removeFromParent()
        let showAndRemoveEnemy = SKAction.sequence([showEnemy, removeEnemy])
        
        let enemyShip1Texture = SKTexture(imageNamed: "enemyShip1")
        enemyShip1 = SKSpriteNode(texture: enemyShip1Texture)
        enemyShip1.position = CGPoint(x: 250, y: CGRectGetMaxY(self.frame) + 200)
//        enemyShip1.size.height = 130
//        enemyShip1.size.width = 154
        enemyShip1.physicsBody = SKPhysicsBody(rectangleOfSize: enemyShip1Texture.size())
        enemyShip1.physicsBody?.dynamic = false
        enemyShip1.runAction(showAndRemoveEnemy)
        
        enemyShip1.physicsBody?.categoryBitMask = CollisionType.Object.rawValue
        enemyShip1.physicsBody?.contactTestBitMask = CollisionType.Laser.rawValue
        enemyShip1.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        self.addChild(enemyShip1)
        
        
//        let enemyShip2Texture = SKTexture(imageNamed: "enemyShip2")
//        enemyShip2 = SKSpriteNode(texture: enemyShip2Texture)
//        enemyShip2.position = CGPoint(x: 500, y: CGRectGetMaxY(self.frame))
//        enemyShip2.size.height = 130
//        enemyShip2.size.width = 154
//        enemyShips.append(enemyShip2)
//        enemyShip2.runAction(showAndRemoveEnemy)
//        self.addChild(enemyShip2)
        
    }
    
    
    //Method creates the power up for the shield Icon to appear
    func createShield (){
        
        let shieldTexture = SKTexture(imageNamed: "PowerUpShield.png")
        shield = SKSpriteNode(texture: shieldTexture)
        shield.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame))
        shield.physicsBody = SKPhysicsBody(rectangleOfSize: shieldTexture.size())
        shield.physicsBody?.dynamic = false
        
        let showShield = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeShield = SKAction.removeFromParent()
        let showAndRemoveShield = SKAction.sequence([showShield, removeShield])
        
        
        shield.physicsBody?.categoryBitMask = CollisionType.PowerUps.rawValue
        shield.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        shield.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        shield.runAction(showAndRemoveShield)
        self.addChild(shield)
    }
    
    
    //Method is called when there is contact between two entities
    func didBeginContact(contact: SKPhysicsContact) {
        
        //Method removes the enemy ship & laser from the screen when it is called
        func enemyDestroyed(enemy: SKSpriteNode, laserShot: SKSpriteNode){
            
            print("Destroyed")
            
            playerLaser.removeFromParent()
            enemyShip1.removeFromParent()
        }
        
        //Declare variables to hold the contact bodies that will cause a action when there is contact between two different entities
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        //Use a conditional to check if the laser hit a enemy ship
        if firstBody.categoryBitMask == CollisionType.Object.rawValue && secondBody.categoryBitMask == CollisionType.Laser.rawValue {
            
            enemyDestroyed(firstBody.node as! SKSpriteNode, laserShot: secondBody.node as! SKSpriteNode)
            
        }
       
        //Conditional statement to check if the player ship contacts a power up. If so remove the power up and alert the player by audio and add the power up
        if (firstBody.categoryBitMask == CollisionType.PowerUps.rawValue && secondBody.categoryBitMask == CollisionType.PlayerShip.rawValue) || (firstBody.categoryBitMask == CollisionType.PlayerShip.rawValue && secondBody.categoryBitMask == CollisionType.PowerUps.rawValue) {
            
            shield.removeFromParent()
            runAction(playerShield)
        }
        
        
    }
    
    
}
