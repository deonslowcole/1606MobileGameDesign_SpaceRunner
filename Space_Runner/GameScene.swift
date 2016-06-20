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
    
    //Create nodes for the player's ship
    var playerShip = SKSpriteNode()
    var shield = SKSpriteNode()
    var playerShipShield = SKSpriteNode()
    var powerUpHealth = SKSpriteNode()
    var playerLaser = SKSpriteNode()
    var shipDamage1 = SKSpriteNode()
    var shipDamage2 = SKSpriteNode()
    var shipDamage3 = SKSpriteNode()
    var powerUpHealthTimer = NSTimer()
    
    //Create nodes for enemy ships
    var enemyShip1 = SKSpriteNode()
    var enemyShip2 = SKSpriteNode()
    var enemyShip3 = SKSpriteNode()
    var enemyShip4 = SKSpriteNode()
    var enemyShip5 = SKSpriteNode()
    var enemyShip6 = SKSpriteNode()
    var enemyLaser = SKSpriteNode()
    var enemyShip1Timer = NSTimer()
    var enemyShip2Timer = NSTimer()
    var enemyShip3Timer = NSTimer()
    var enemyExplode1 = SKSpriteNode()
    var enemyExplode2 = SKSpriteNode()
    var enemyExplode3 = SKSpriteNode()
    
    //Create nodes for meteor
    var meteor1 = SKSpriteNode()
    var meteor2 = SKSpriteNode()
    var meteor3 = SKSpriteNode()
    var meteor4 = SKSpriteNode()
    var meteor5 = SKSpriteNode()
    var meteor1Timer = NSTimer()
    var meteor2Timer = NSTimer()
    var meteor3Timer = NSTimer()
    var meteor4Timer = NSTimer()
    var meteor5Timer = NSTimer()
    
    //Create a label node to display the player's score
    var scoreLabel = SKLabelNode()
    
    //Declare a variable to hold the hit count of the player's ship damage
    var hitCount = 0
    
    //Declare a variable to hold the players score
    var playerScore = 0
    
    //Create a node for the pause button.
    var pauseButton = SKSpriteNode()
    
    //Node that will hold all of the objects for reload
    var allObjects = SKSpriteNode()
    
    //Create a enum for the collision detection
    enum CollisionType: UInt32 {
        
        case PlayerShip = 1
        case Object = 2
        case Laser = 4
//        case ShieldPowerUp = 5
        case EnemyLaser = 8
        case HealthPowerUp = 16
        case PlayerShipShield = 32
        case enemyShip = 64
    }
    
    //Create a node for the background image
    var spaceBackground = SKSpriteNode()
    
    //Create emmiter nodes to add effect/animation to the scene.
    let rain = SKEmitterNode(fileNamed: "Rain.sks")
    
    
    //Declare constants for audio
    let playerLaserAudio = SKAction.playSoundFileNamed("PlayerLaserShot.mp3", waitForCompletion: true)
    let enemyLaserAudio = SKAction.playSoundFileNamed("EnemyLaserShot.mp3", waitForCompletion: true)
    let playerHealthAudio = SKAction.playSoundFileNamed("powerUpHealth.mp3", waitForCompletion: true)
    let enemyBlownUp = SKAction.playSoundFileNamed("EnemyBlowUp.mp3", waitForCompletion: true)
    let playerBlownUp = SKAction.playSoundFileNamed("MissionFailed.mp3", waitForCompletion: true)
    
    
    //Declre a constant for the sprite sheets to pull sprites from.
    let spriteSheet = SpaceRunnerSprites()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Call the function to make the game HUD
        showHUD()
        
        self.addChild(allObjects)
        
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
        
        //Call the method to create the player's ship
        createPlayerShip()
        
        
        let playerShipShieldTexture = SKTexture(imageNamed: "PlayerShipShield.png")
        playerShipShield = SKSpriteNode(texture: playerShipShieldTexture)
        
    
       //Call the method to add the enemy ships
        runEnemyShipTimer()
        
        //Call the method to add the enemy ships
        runMeteorTimer()
        
        //Set textures for the player ship damage
        shipDamage1 = SKSpriteNode(texture: spriteSheet.playerShipDamage1())
        shipDamage2 = SKSpriteNode(texture: spriteSheet.playerShipDamage2())
        shipDamage3 = SKSpriteNode(texture: spriteSheet.playerShipDamage3())
        
        
        //Create emmiter nodes to add effect/animation to the scene.
        rain?.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        self.addChild(rain!)
        
        let fire = SKEmitterNode(fileNamed: "Fire.sks")
        fire?.position
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
                } else if name == "moveLeftButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(-800, 0)
                } else if name == "moveRightButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(800, 0)
                } else if name == "PauseButton" {
                    pauseAlert()
                }
            }
            
        }
        
    }
    

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        playerShip.physicsBody?.velocity = CGVectorMake(0, 0)
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */

        //Create the movement for the emeny ships. Use the min & max time to set the speed. Declare a random number and add the remainder to the min time. Set that as how fast the enemy ship should move throughout the scene.
        let minTime = 4.0
        let maxTime = 8.0
        let rangeTime = maxTime - minTime
        let actualTime = (arc4random() % UInt32(rangeTime)) + UInt32(minTime)
        
        let toPlayer = SKAction.moveToX(playerShip.position.x, duration: NSTimeInterval(actualTime))
        
        //Add the action to the enemy ships
        enemyShip1.runAction(toPlayer)
        enemyShip2.runAction(toPlayer)
        enemyShip3.runAction(toPlayer)
        
       
        //Update the score when the player destroys a enemy ship.
        scoreLabel.text = "Score: " + "\(playerScore)"
        
        
    }
    
    //MARK: Functions
    
    //Method to be used as various
    func variousXPoints() -> CGFloat {
        
        let xPoints = arc4random_uniform(1080)
        
        return CGFloat(xPoints)
        
    }
    
    //Method that calls all of the timers to run in order to show the enemy ships in the scene
    func runEnemyShipTimer (){
        
        //Set the timer for displaying the enemy ships
        enemyShip1Timer = NSTimer.scheduledTimerWithTimeInterval(13, target: self, selector: #selector(GameScene.showEnemyShip1), userInfo: nil, repeats: true)
        
        enemyShip2Timer = NSTimer.scheduledTimerWithTimeInterval(17, target: self, selector: #selector(GameScene.showEnemyShip2), userInfo: nil, repeats: true)
        
        enemyShip3Timer = NSTimer.scheduledTimerWithTimeInterval(22, target: self, selector: #selector(GameScene.showEnemyShip3), userInfo: nil, repeats: true)

    }
    
    //Method that calls all of the timers to run in order to show the meteors in the scene
    func runMeteorTimer () {
        
        meteor1Timer = NSTimer.scheduledTimerWithTimeInterval(22, target: self, selector: #selector(GameScene.createMetor1), userInfo: nil, repeats: true)
        
        meteor2Timer = NSTimer.scheduledTimerWithTimeInterval(19, target: self, selector: #selector(GameScene.createMetor2), userInfo: nil, repeats: true)
        
        meteor3Timer = NSTimer.scheduledTimerWithTimeInterval(14, target: self, selector: #selector(GameScene.createMetor3), userInfo: nil, repeats: true)
        
        meteor4Timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameScene.createMetor4), userInfo: nil, repeats: true)
        
        meteor5Timer = NSTimer.scheduledTimerWithTimeInterval(7, target: self, selector: #selector(GameScene.createMetor5), userInfo: nil, repeats: true)
    }
    
    //Method that call the timer for the player health power up
    func createPowerUpHealth() {
        
        if hitCount > 0 {
            powerUpHealthTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameScene.createHealth), userInfo: nil, repeats: true)
        }
    }
    
    //Method calls for the laser to be shot when the player presses the fire button
    func shootLaser() {
        
        //Create a texture for the sprite and set it to the sprite node
        playerLaser = SKSpriteNode(texture: spriteSheet.laserRed())
        
        //Set the z position so that the sprite is behind the players ship
        playerLaser.zPosition = -0.5
        
        //Set the position of the sprite equal to the anchor point of the player ship and set the height and width.
        playerLaser.position.x = playerShip.anchorPoint.x
        playerLaser.position.y = playerShip.position.y - 300
        
        //Create the physics body for the player ship's laser
        playerLaser.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.laserRed().size())
        playerLaser.physicsBody?.dynamic = true
        playerLaser.physicsBody?.affectedByGravity = false
        
        //Set the mask to detect the types of collisions for the player ship's laser
        playerLaser.physicsBody?.categoryBitMask = CollisionType.Laser.rawValue
        playerLaser.physicsBody?.contactTestBitMask = CollisionType.Object.rawValue
//        playerLaser.physicsBody?.collisionBitMask = CollisionType.ShieldPowerUp.rawValue
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let shoot = SKAction.moveToY(self.size.height, duration: 0.5)
        playerLaser.runAction(shoot)
        
        //Add the laser to the player ship so that it will move as the player's ship moves
        playerShip.addChild(playerLaser)
        
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
    
    //MARK: Create Player Ship
    func createPlayerShip(){
        
        playerShip = SKSpriteNode(texture: spriteSheet.playerShip())
        playerShip.position = CGPointMake(self.size.width/2, self.size.height/5)
        
        playerShip.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.playerShip().size())
        playerShip.physicsBody?.dynamic = true
        playerShip.physicsBody?.affectedByGravity = false
        playerShip.physicsBody?.allowsRotation = false
        
        playerShip.physicsBody?.categoryBitMask = CollisionType.PlayerShip.rawValue
        playerShip.physicsBody?.contactTestBitMask = CollisionType.Object.rawValue
        playerShip.physicsBody?.collisionBitMask = CollisionType.PlayerShip.rawValue
        
        allObjects.addChild(playerShip)
        
    }
    
    
    
    
    //MARK: Meteors
    
    func createMetor1 () {
        
        meteor1 = SKSpriteNode(texture: spriteSheet.meteor1())
        meteor1.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        meteor1.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.meteor1().size())
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
    
    
    //MARK: Power Ups
    
    //Method creates the power up for the Health Icon to appear
    func createHealth () {
        
        powerUpHealth = SKSpriteNode(texture: spriteSheet.PowerUpHealth())
        powerUpHealth.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        powerUpHealth.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.PowerUpHealth().size())
        powerUpHealth.physicsBody?.dynamic = false
        
        let showHealthPowerUp = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removeHealthPowerUp = SKAction.removeFromParent()
        let showAndRemoveHealthPowerUp = SKAction.sequence([showHealthPowerUp, removeHealthPowerUp])
        
        powerUpHealth.physicsBody?.categoryBitMask = CollisionType.HealthPowerUp.rawValue
        powerUpHealth.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        powerUpHealth.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        powerUpHealth.runAction(showAndRemoveHealthPowerUp)
        self.addChild(powerUpHealth)
        
    }
    
    
    
    //MARK: HUD Functions
    //Method is used to create the HUD for the game
    func showHUD () {
        
        //Create the container that will hold the info for the player. Create it as a sprite node, anchor it in the center of the scene, set the zPosition so that all the other sprites will appear behind it and set the position to the left of the scene and to the top by subtracting the height of the hub from the height of the scene. Add it to the scene.
        let hudContainer = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.frame.width, self.frame.height * 0.05))
        hudContainer.anchorPoint = CGPointMake(0, 0)
        hudContainer.zPosition = 2.0
        hudContainer.position = CGPointMake(0, self.size.height - hudContainer.size.height)
        self.addChild(hudContainer)
        
        
        //Create a texture and set it equal to the node. Create the size and set the it to the center of the HUD. Give it a name to identifiy when it has been touched and add it to the scene.
        pauseButton = SKSpriteNode(texture: spriteSheet.pauseButton())
        pauseButton.size = CGSizeMake(hudContainer.size.width / 10, hudContainer.size.height)
        pauseButton.position = CGPointMake(hudContainer.size.width - 100, hudContainer.size.height / 2)
        pauseButton.name = "PauseButton"
        hudContainer.addChild(pauseButton)
        
        
        //Display the score to the player
        scoreLabel.position = CGPointMake(hudContainer.size.width / 4, 1)
        scoreLabel.text = "Score: " + "\(playerScore)"
        scoreLabel.fontSize = hudContainer.size.height
        scoreLabel.fontColor = UIColor.blackColor()
        hudContainer.addChild(scoreLabel)
        
    }
    
    //Use this method to show an alert when the user has paused the game. Allow the player to continue playing
    func pauseAlert(){
        
        view!.paused = true
        enemyShip1Timer.invalidate()
        enemyShip2Timer.invalidate()
        enemyShip3Timer.invalidate()
        meteor1Timer.invalidate()
        meteor2Timer.invalidate()
        meteor3Timer.invalidate()
        meteor4Timer.invalidate()
        meteor5Timer.invalidate()
        
        let alert = UIAlertController(title: "Space Runner", message: "Game Paused", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Continue Playing", style: UIAlertActionStyle.Default) { _ in
            self.view?.paused = false
            self.runEnemyShipTimer()
            self.runMeteorTimer()
        })
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: Game Over Function
    func gameOver () {
        
        let alert = UIAlertController(title: "Space Runner", message: "Game Over", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default) { _ in
            self.allObjects.removeAllChildren()
            self.playerScore = 0
            self.hitCount = 0
            self.fireButton?.userInteractionEnabled = true
            self.pauseButton.userInteractionEnabled = true
            self.rain?.paused = false
            self.createPlayerShip()
            self.runMeteorTimer()
            self.runEnemyShipTimer()
            self.speed = 1
        })
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Contact Functions
    
    //Method is called when there is contact between two entities
    func didBeginContact(contact: SKPhysicsContact) {
        
        let playerExplode = SKAction.animateWithTextures(spriteSheet.playerExplode(), timePerFrame: 0.08)
        let enemyExplode = SKAction.animateWithTextures(spriteSheet.enemyExplode(), timePerFrame: 0.03)
        let fade = SKAction.fadeOutWithDuration(0.05)
        let remove = SKAction.removeFromParent()
        let enemyExplodeAndFade = SKAction.sequence([enemyExplode, fade, remove])
        let playerExplodeAndFade = SKAction.sequence([playerExplode, fade, remove])
        
        
        //Method runs add one when the player's ship has been hit/damaged
        func playerShipHit () {
            
            hitCount = hitCount + 1
            
            if hitCount == 1 {
                createPowerUpHealth()
            }
        }
        
        
        //Declare variables to hold the contact bodies that will cause a action when there is contact between two different entities
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        //Use a conditional to check if the laser hit a enemy ship
        if firstBody.categoryBitMask == CollisionType.Object.rawValue && secondBody.categoryBitMask == CollisionType.Laser.rawValue || firstBody.categoryBitMask == CollisionType.Laser.rawValue && secondBody.categoryBitMask == CollisionType.Object.rawValue {
            
            
            if firstBody.node!.name == "enemyShip1" || secondBody.node!.name == "enemyShip1" {
                enemyShip1.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 20
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            } else if firstBody.node!.name == "enemyShip2" || secondBody.node!.name == "enemyShip2" {
                enemyShip2.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 20
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            } else if firstBody.node!.name == "enemyShip3" || secondBody.node!.name == "enemyShip3" {
                enemyShip3.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 20
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            }
          
            
        }
        

       
        //Conditional statement to check if the player ship contacts a power up. If so remove the power up and alert the player by audio and add the power up
        if (firstBody.categoryBitMask == CollisionType.HealthPowerUp.rawValue && secondBody.categoryBitMask == CollisionType.PlayerShip.rawValue) || (firstBody.categoryBitMask == CollisionType.PlayerShip.rawValue && secondBody.categoryBitMask == CollisionType.HealthPowerUp.rawValue) {
            
            switch hitCount {
            case 1:
                shipDamage1.removeFromParent()
                powerUpHealth.removeFromParent()
                runAction(playerHealthAudio)
                powerUpHealthTimer.invalidate()
                hitCount = hitCount - 1
                playerScore = playerScore + 30
            case 2:
                shipDamage2.removeFromParent()
                powerUpHealth.removeFromParent()
                runAction(playerHealthAudio)
                hitCount = hitCount - 1
                playerScore = playerScore + 40
            case 3:
                shipDamage3.removeFromParent()
                powerUpHealth.removeFromParent()
                runAction(playerHealthAudio)
                hitCount = hitCount - 1
                playerScore = playerScore + 50
            default:
                print("No More Health")
            }
            
            
        }
        
        
        if firstBody.categoryBitMask == CollisionType.PlayerShip.rawValue && secondBody.categoryBitMask == CollisionType.EnemyLaser.rawValue {
            
            playerShipHit()
            
            switch hitCount {
            case 1 :
                enemyLaser.removeFromParent()
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage1)
            case 2:
                enemyLaser.removeFromParent()
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage2)
            case 3:
                enemyLaser.removeFromParent()
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage3)
            default:
                playerShip.removeAllChildren()
                playerShip.runAction(playerExplodeAndFade)
                enemyLaser.removeFromParent()
                runAction(playerBlownUp)
                enemyShip1Timer.invalidate()
                enemyShip2Timer.invalidate()
                enemyShip3Timer.invalidate()
                meteor1Timer.invalidate()
                meteor2Timer.invalidate()
                meteor3Timer.invalidate()
                meteor4Timer.invalidate()
                meteor5Timer.invalidate()
                powerUpHealthTimer.invalidate()
                fireButton?.userInteractionEnabled = false
                pauseButton.userInteractionEnabled = false
                rain?.paused = true
                _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GameScene.gameOver), userInfo: nil, repeats: false)
                
            }
            
        }
        
    }
    
    
}
