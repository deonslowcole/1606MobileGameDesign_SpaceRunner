//
//  GameScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/2/16.
//  Copyright (c) 2016 Deon Cole. All rights reserved.
//

import SpriteKit
import CoreMotion


//Declare a constant for the sprite sheets to pull sprites from.
let spriteSheet = SpaceRunnerSprites()

//Declare a variable for collected experience points
var collectedPoints = 0


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //Create nodes for the UI Control and a variable to hold the amount of times the player shoots
    var fireButton = SKSpriteNode()
    var shotCount = 0
    
    //Create nodes for the focus button
    var focusBkg = SKSpriteNode()
    var focus1 = SKSpriteNode()
    var focus2 = SKSpriteNode()
    var focus3 = SKSpriteNode()
    var focus4 = SKSpriteNode()
    var focus5 = SKSpriteNode()
    var focus6 = SKSpriteNode()
    var focus7 = SKSpriteNode()
    var focusCount = 0
    
    var powerUpFocus = SKSpriteNode()
    var powerUpFocusTimer = NSTimer()
    
    //Create nodes for the player's ship
    var playerShip = SKSpriteNode()
    var shield = SKSpriteNode()
    var powerUpHealth = SKSpriteNode()
    var playerLaser = SKSpriteNode()
    var shipDamage1 = SKSpriteNode()
    var shipDamage2 = SKSpriteNode()
    var shipDamage3 = SKSpriteNode()
    var powerUpHealthTimer = NSTimer()
    
    //Create nodes for enemy ships
    var enemyBlack1 = SKSpriteNode()
    var enemyBlack2 = SKSpriteNode()
    var enemyBlack3 = SKSpriteNode()
    var enemyBlack4 = SKSpriteNode()
    var enemyBlack5 = SKSpriteNode()
    var enemyShip6 = SKSpriteNode()
    var enemyLaser = SKSpriteNode()
    var enemyShipBlack1Timer = NSTimer()
    var enemyShipBlack2Timer = NSTimer()
    var enemyShipBlack3Timer = NSTimer()
    var enemyShipBlack4Timer = NSTimer()
    var enemyShipBlack5Timer = NSTimer()
    var enemiesDestroyed = 0
    
    //Create nodes for meteors
    var meteor1 = SKSpriteNode()
    var meteor2 = SKSpriteNode()
    var meteor3 = SKSpriteNode()
    var meteor4 = SKSpriteNode()
    var meteor5 = SKSpriteNode()
    var meteor6 = SKSpriteNode()
    var meteor7 = SKSpriteNode()
    var meteor8 = SKSpriteNode()
    var meteor1Timer = NSTimer()
    var meteor2Timer = NSTimer()
    var meteor3Timer = NSTimer()
    var meteor4Timer = NSTimer()
    var meteor5Timer = NSTimer()
    var meteor6Timer = NSTimer()
    var meteor7Timer = NSTimer()
    var meteor8Timer = NSTimer()
    
    
    
    //Create a label node to display the player's score
    var scoreLabel = SKLabelNode()
    
    //Declare a variable to hold the hit count of the player's ship damage
    var hitCount = 0
    
    //Declare a variable to hold the player's score and the final score to be use for gaining extra xp
    var playerScore = 0
    var finalScore = 0
    
    //Declare a variable for the game speed & timer
    var gameSpeed: CGFloat = 1.0
    var gameSpeedTimer = NSTimer()
    var gameSpeedCount = 0
    
    //Create a node for the pause button.
    var pauseButton = SKSpriteNode()
    
    //Node that will hold all of the objects for reload
    var allObjects = SKSpriteNode()
    
    //Create a enum for the collision detection
    enum CollisionType: UInt32 {
        
        case PlayerShip = 1
        case Object = 2
        case Laser = 4
        case EnemyLaser = 8
        case HealthPowerUp = 16
        case PlayerShipShield = 32
        case enemyShip = 64
        case FocusPowerUp = 128
    }
    
    
    //Create a node for the background image
    var spaceBackground = SKSpriteNode()
    
    
    //Create nodes for menu
    var menuContainer = SKSpriteNode()
    var gameTitle = SKSpriteNode()
    var playButton1 = SKSpriteNode()
    var playButton2 = SKSpriteNode()
    var tutorialButton = SKSpriteNode()
    var aboutButton = SKSpriteNode()
    var rocket = SKSpriteNode()
    
    //Create emmiter nodes to add effect/animation to the scene.
    let rain = SKEmitterNode(fileNamed: "Rain.sks")
    
    
    //Declare constants for audio
    let playerLaserAudio = SKAction.playSoundFileNamed("PlayerLaserShot.mp3", waitForCompletion: true)
    let enemyLaserAudio = SKAction.playSoundFileNamed("EnemyLaserShot.mp3", waitForCompletion: true)
    let playerHealthAudio = SKAction.playSoundFileNamed("powerUpHealth.mp3", waitForCompletion: true)
    let enemyBlownUp = SKAction.playSoundFileNamed("EnemyBlowUp.mp3", waitForCompletion: true)
    let playerBlownUp = SKAction.playSoundFileNamed("MissionFailed.mp3", waitForCompletion: true)
    let dissolve = SKAction.playSoundFileNamed("Dissolve.mp3", waitForCompletion: true)
    let twoTone = SKAction.playSoundFileNamed("TwoTone.mp3", waitForCompletion: true)
    let go = SKAction.playSoundFileNamed("Go", waitForCompletion: true)

    
    //Declare a variable to be instantiated for core motion
    var coreMotion = CMMotionManager()
    
    //Declare a variable to hold the x-axis position when the accelerometer is active
    var playerShipDestX: CGFloat = 0.0
    
    //Declare a variable for experience points
    var exPoints = 0
    
    //Declare a variable to hold the timer for the experience points
    var exPtsTimer = NSTimer()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        //Set the delegate equal to self
        self.physicsWorld.contactDelegate = self
        
        coreMotion.accelerometerUpdateInterval = 0.02
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        
        //Create texture for the background scene. Set the node equal to the texture and position it in the middle of the scene. Set the height and width equal to the full frame. Set the z position to the far back and add the background to the scene.
        let spaceBackgroundTexture = SKTexture(imageNamed: "SpaceBackground.png")
        spaceBackground = SKSpriteNode(texture: spaceBackgroundTexture)
        spaceBackground.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        spaceBackground.size.height = self.frame.height
        spaceBackground.size.width = self.frame.width
        spaceBackground.zPosition = -1.0
        self.addChild(spaceBackground)
        
        
        //Create emmiter nodes to add effect/animation to the scene.
        rain?.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        self.addChild(rain!)
        
        //Call the function to show the menu to the player
        showMenu()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameScene.scheduleNotification), name: "local-Notifications", object: nil)
        
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
                    shotCount = shotCount + 1
                    createPowerUpFocus()
                    speedGameUp()
                } else if name == "moveLeftButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(-800, 0)
                } else if name == "moveRightButton" {
                    playerShip.physicsBody?.velocity = CGVectorMake(800, 0)
                } else if name == "PauseButton" {
                    pauseAlert()
                } else if name == "Play" {
                    menuContainer.removeFromParent()
                    runAction(go)
                    loadGame()
                } else if name == "Tutorial" {
                    let tutorialScene = TutorialScene(size: self.size)
                    let transition = SKTransition.fadeWithDuration(1.0)
                    tutorialScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(dissolve)
                    self.scene!.view?.presentScene(tutorialScene, transition: transition)
                } else if name == "About" {
                    let aboutScene = AboutScene(size: self.size)
                    let transition = SKTransition.fadeWithDuration(1.0)
                    aboutScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(dissolve)
                    self.scene?.view?.presentScene(aboutScene, transition: transition)
                } else if name == "Rocket" {
                    let mcScene = MissonControlScene(size: self.size)
                    let transition = SKTransition.fadeWithDuration(0.5)
                    mcScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(dissolve)
                    self.scene?.view?.presentScene(mcScene, transition: transition)
                } else if name == "Focus" {
                    if focusCount == 6 {
                        focusCount = 0
                        focusBkg.removeAllActions()
                        self.speed = gameSpeed / 2
                        runGameSpeedTimer()
                    }
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
        enemyBlack1.runAction(toPlayer)
        enemyBlack2.runAction(toPlayer)
        enemyBlack3.runAction(toPlayer)
        enemyBlack4.runAction(toPlayer)
        enemyBlack5.runAction(toPlayer)
        
        //Declare a action to move the player's ship by the playerShipDestX variable and run the action in the player's ship
        let playerShipMove = SKAction.moveToX(playerShipDestX, duration: 0.05)
        playerShip.runAction(playerShipMove)
        
        
        
        //Update the score when the player destroys a enemy ship.
        scoreLabel.text = "Score: " + "\(playerScore)"
        
        
    }
    
    //MARK: Notification
    //Method creates the local notification on teh device. Declare a variable to be th given xp points. use a switch statement to check the player's score and set the extra xp points. Add it to the value of the player's collected points. Initialize a variable to hold the local notification. Declare a variable to hold the start of the local notification. Declare a variable to hold the amount of time (in seconds)when the notification should happen. It is set to 4 hours. Set the fire date equal to the notification time. Set the message to the user along with the timezone, badge number and default sound. Scheduele the notification after setup.
    func scheduleNotification() {
        
        var extraXP = 0
        
        switch finalScore {
        case 0...50:
            extraXP = 50
            collectedPoints = collectedPoints + extraXP
            NSUserDefaults.standardUserDefaults().setObject(collectedPoints, forKey: "experiencePoints")
        case 51...150:
            extraXP = 100
            collectedPoints = collectedPoints + extraXP
            NSUserDefaults.standardUserDefaults().setObject(collectedPoints, forKey: "experiencePoints")
        case 151...400:
            extraXP = 150
            collectedPoints = collectedPoints + extraXP
            NSUserDefaults.standardUserDefaults().setObject(collectedPoints, forKey: "experiencePoints")
        case 401...800:
            extraXP = 200
            collectedPoints = collectedPoints + extraXP
            NSUserDefaults.standardUserDefaults().setObject(collectedPoints, forKey: "experiencePoints")
        default:
            break
       
        }
        
        
        let notification = UILocalNotification()
        
        let startDate = NSDate()
        
        let notificationTime = startDate.dateByAddingTimeInterval(5) //14400
        
        
        notification.fireDate = notificationTime
        notification.alertBody = "Time to fly, you've recieved a bonus \(extraXP)xp"
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.applicationIconBadgeNumber = 1
        notification.soundName = UILocalNotificationDefaultSoundName
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    }
    
    
    //MARK: Menu
    
    func showMenu() -> SKSpriteNode{
        
        //Create a container to hold the menu items when the game loads
        menuContainer = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(self.frame.width * 0.7, self.frame.height * 0.6))
        menuContainer.anchorPoint = CGPointMake(0, 0)
        menuContainer.name = "Menu"
        menuContainer.zPosition = 1.0
        menuContainer.position = CGPointMake(self.size.width/6.5, self.size.height/4)
        self.addChild(menuContainer)
        
        
        let gameTitleTexture = SKTexture(imageNamed: "SpaceRunnerTitle.png")
        gameTitle = SKSpriteNode(texture: gameTitleTexture)
        gameTitle.size = CGSizeMake(menuContainer.size.width, menuContainer.size.height/5)
        gameTitle.position = CGPointMake(menuContainer.size.width - gameTitle.size.width, menuContainer.size.height - gameTitle.size.height)
        gameTitle.anchorPoint = CGPointMake(0,0)
        menuContainer.addChild(gameTitle)
        
        let playButton1texture = SKTexture(imageNamed: "Play1.png")
        playButton1 = SKSpriteNode(texture: playButton1texture)
        playButton1.name = "Play"
        playButton1.size = CGSizeMake(menuContainer.size.width / 4, menuContainer.size.height/6)
        playButton1.position = CGPointMake(menuContainer.size.width/2.5, gameTitle.position.y - 200)
        playButton1.anchorPoint = CGPointMake(0, 0)
        
        let playButton2Texture = SKTexture(imageNamed: "Play2.png")
        playButton2 = SKSpriteNode(texture: playButton2Texture)
        
        let playFlash = SKAction.animateWithTextures([playButton2Texture, playButton1texture], timePerFrame: 0.5)
        let keepFlashing = SKAction.repeatActionForever(playFlash)
        playButton1.runAction(keepFlashing)
        menuContainer.addChild(playButton1)
        
        
        let tutorialButtonTexture = SKTexture(imageNamed: "TutorialButton.png")
        tutorialButton = SKSpriteNode(texture: tutorialButtonTexture)
        tutorialButton.name = "Tutorial"
        tutorialButton.size = CGSizeMake(menuContainer.size.width / 2, menuContainer.size.height / 6)
        tutorialButton.position = CGPointMake(menuContainer.size.width/3.5, playButton1.position.y - 200)
        tutorialButton.anchorPoint = CGPointMake(0, 0)
        menuContainer.addChild(tutorialButton)
        
        let aboutButtonTexture = SKTexture(imageNamed: "AboutButton.png")
        aboutButton = SKSpriteNode(texture: aboutButtonTexture)
        aboutButton.name = "About"
        aboutButton.size = CGSizeMake(menuContainer.size.width / 4, menuContainer.size.height / 5)
        aboutButton.position = CGPointMake(menuContainer.size.width/2.5, tutorialButton.position.y - 200)
        aboutButton.anchorPoint = CGPointMake(0, 0)
        menuContainer.addChild(aboutButton)
        
        rocket = SKSpriteNode(texture: spriteSheet.gameRocket())
        rocket.name = "Rocket"
        rocket.size = CGSizeMake(menuContainer.size.width / 6, menuContainer.size.height / 7)
        rocket.position = CGPointMake(menuContainer.size.width - (menuContainer.size.width / 7), 100)
        menuContainer.addChild(rocket)
        
        
        return menuContainer
        
    }
    
    
    
    //MARK: Functions
    
    //Method loads the game
    func loadGame() {
        
        
        
        //Use optional binding to check if there are any stored xp. If there are, start the game with what is there else the start with 0 xp.
        if let xp = NSUserDefaults.standardUserDefaults().objectForKey("collectedPoints") {
            
            collectedPoints = Int(xp as! NSNumber)
            
        } else {
            
            collectedPoints = 0
        }
        
        
        //Call the function to make the game HUD
        showHUD()
        
        self.addChild(allObjects)
        
        //Call the method to create the player's ship
        createPlayerShip()
        
        //Call the method to create the fire button
        createFireButton()
        
        //Call the method to create the focus button
        createFocusButton()
        
        //Call the method to add the enemy ships
        runEnemyShipTimer()
        
        //Call the method to add the enemy ships
        runMeteorTimer()
        
        //Call the method to run the timer for creating experience points
        runExPointsTimer()
        
        //Set textures for the player ship damage
        shipDamage1 = SKSpriteNode(texture: spriteSheet.playerShipDamage1())
        shipDamage2 = SKSpriteNode(texture: spriteSheet.playerShipDamage2())
        shipDamage3 = SKSpriteNode(texture: spriteSheet.playerShipDamage3())
        
        
        //Use a conditional to check if the accelerometer is available
        if coreMotion.accelerometerAvailable == true {
            
            //The update queue reads and checks for updates for movement from the accelerometer
            coreMotion.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (data, error) in
                
                //Declare a constant equal to the player ship x-axis position
                let playerShipPosition = self.playerShip.position.x
                
                //Conditional to check if the data value is negative (less than 0). If so move the player ship to the left. If it is greater than 0 move the player ship to the right. Set the playerShipDestX variable equal to the value of the movement.
                if data?.acceleration.x < 0 {
                    
                    self.playerShipDestX = playerShipPosition + CGFloat((data?.acceleration.x)! * 150)
                    
                } else if data?.acceleration.x > 0 {
                    
                    self.playerShipDestX = playerShipPosition + CGFloat((data?.acceleration.x)! * 150)
                    
                }
                
            })
            
        }
        
        
        //Add a left bound to the scene so the players ship doesn't go off the screen. Declare a constant as a SKNode. Set the starting position of the left bound to the bottom left corner. Make the bound a rectangle with the x size to .0 and the height equal to the size of the frame. Add it to the scene. Repeat for the right bound
        let leftBound = SKNode()
        leftBound.position = CGPointMake(0, 0)
        leftBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, self.frame.height))
        leftBound.physicsBody?.dynamic = true
        self.addChild(leftBound)
        
        let rightBound = SKNode()
        rightBound.position = CGPointMake(self.frame.width, 0)
        rightBound.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0.1, self.frame.height))
        rightBound.physicsBody?.dynamic = false
        self.addChild(rightBound)
        
    }
    
    
    
    //Method to be used as various
    func variousXPoints() -> CGFloat {
        
        let xPoints = arc4random_uniform(1080)
        
        return CGFloat(xPoints)
        
    }
    
    //Method that calls all of the timers to run in order to show the enemy ships in the scene
    func runEnemyShipTimer (){
        
        //Set the timer for displaying the enemy ships
        enemyShipBlack1Timer = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(GameScene.showEnemyShipBlack1), userInfo: nil, repeats: true)
        
        enemyShipBlack2Timer = NSTimer.scheduledTimerWithTimeInterval(11, target: self, selector: #selector(GameScene.showEnemyShipBlack2), userInfo: nil, repeats: true)
        
        enemyShipBlack3Timer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(GameScene.showEnemyShipBlack3), userInfo: nil, repeats: true)
        
        enemyShipBlack4Timer = NSTimer.scheduledTimerWithTimeInterval(19, target: self, selector: #selector(GameScene.showEnemyShipBlack4), userInfo: nil, repeats: true)
        
        enemyShipBlack5Timer = NSTimer.scheduledTimerWithTimeInterval(24, target: self, selector: #selector(GameScene.showEnemyShipBlack5), userInfo: nil, repeats: true)
        
    }
    
    //Method that calls all of the timers to run in order to show the meteors in the scene
    func runMeteorTimer () {
        
        meteor1Timer = NSTimer.scheduledTimerWithTimeInterval(26, target: self, selector: #selector(GameScene.createMeteor1), userInfo: nil, repeats: true)
        
        meteor2Timer = NSTimer.scheduledTimerWithTimeInterval(23, target: self, selector: #selector(GameScene.createMeteor2), userInfo: nil, repeats: true)
        
        meteor3Timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(GameScene.createMeteor3), userInfo: nil, repeats: true)
        
        meteor4Timer = NSTimer.scheduledTimerWithTimeInterval(17, target: self, selector: #selector(GameScene.createMeteor4), userInfo: nil, repeats: true)
        
        meteor5Timer = NSTimer.scheduledTimerWithTimeInterval(11, target: self, selector: #selector(GameScene.createMeteor5), userInfo: nil, repeats: true)
        
        meteor6Timer = NSTimer.scheduledTimerWithTimeInterval(8, target: self, selector: #selector(GameScene.createMeteor6), userInfo: nil, repeats: true)
        
        meteor7Timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(GameScene.createMeteor7), userInfo: nil, repeats: true)
        
        meteor8Timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.createMeteor8), userInfo: nil, repeats: true)
        
    }
    
    
    func runExPointsTimer (){
        
        //Run timer to create experience points
        exPtsTimer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(GameScene.createExPoints), userInfo: nil, repeats: true)
        
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
        
        //Create a action to move the laser along the y axis with a duration of half a second and run the action
        let shoot = SKAction.moveToY(self.size.height, duration: 0.5)
        playerLaser.runAction(shoot)
        
        //Add the laser to the player ship so that it will move as the player's ship moves
        playerShip.addChild(playerLaser)
        
    }
    
    //Method that runs the timer for the player's experience points
    func createExPoints() {
        
        exPoints = exPoints + 10
        
        print(exPoints)
        
    }
    
    //Method creates the focus button
    func createFocusButton() {
        
        focusBkg = SKSpriteNode(texture: spriteSheet.FocusBackground())
        focusBkg.name = "Focus"
        focusBkg.position = CGPointMake(self.size.width / 7, 120.0)
        focusBkg.zPosition = 2
        self.addChild(focusBkg)
        
    }
    
    //Method keeps track of the time that runs when the focus meter is full. If the count equals 5 set the game speed back to what it was and stop the timer.
    func gameSpeedCounter() {
        
        gameSpeedCount += 1
        
        if gameSpeedCount == 5 {
            
            self.speed = gameSpeed
            gameSpeedTimer.invalidate()
        }
    }
    
    //Method runds the timer for the game speed when the focus button has been touched. Set the speed to half and run the timer for 10 seconds
    func runGameSpeedTimer() {
        
        gameSpeedTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(GameScene.gameSpeedCounter), userInfo: nil, repeats: true)
            
    }
    
    func speedGameUp() {
        
        if enemiesDestroyed == 35 {
            
            gameSpeed = gameSpeed + 1
            
            self.speed = gameSpeed
        
            enemiesDestroyed = 0
        }

    }
    
    
    //MARK: Create Player Ship
    func createPlayerShip(){
        
        if let ship = NSUserDefaults.standardUserDefaults().objectForKey("theShip") {
            
            let theShip = SKTexture(imageNamed: ship as! String)
            playerShip = SKSpriteNode(texture: theShip)
            
        } else {
            
            playerShip = SKSpriteNode(texture: spriteSheet.playerShipRed())
            
        }
    
        playerShip.name = "Player Ship"
        playerShip.position = CGPointMake(self.size.width/2, self.size.height/5)
        
        playerShip.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.playerShipRed().size())
        playerShip.physicsBody?.dynamic = true
        playerShip.physicsBody?.affectedByGravity = false
        playerShip.physicsBody?.allowsRotation = false
        
        playerShip.physicsBody?.categoryBitMask = CollisionType.PlayerShip.rawValue
        playerShip.physicsBody?.contactTestBitMask = CollisionType.Object.rawValue
        playerShip.physicsBody?.collisionBitMask = CollisionType.PlayerShip.rawValue
        
        //Create Emitter node for flames to add to player's ship
        let fire = SKEmitterNode(fileNamed: "Fire.sks")
        fire?.name = "Fire"
        fire?.position
        playerShip.addChild(fire!)
        
        allObjects.addChild(playerShip)
        
    }
    
    func createFireButton() {
        
        fireButton = SKSpriteNode(texture: spriteSheet.FireButtonLight())
        fireButton.name = "fireButton"
        fireButton.position = CGPointMake(self.size.width / 2, 120.0)
        fireButton.zPosition = 2
        fireButton.size = CGSize(width: 160.0, height: 160.0)
        self.addChild(fireButton)
        
    }
    
    
    //MARK: Power Up
    
    //Method runs the action for the power up to appear
    func movePowerUp() -> SKAction {
        
        let showPowerUp = SKAction.moveByX(0, y: -self.frame.height, duration: NSTimeInterval(self.frame.height / 400))
        let removePowerUp = SKAction.removeFromParent()
        let showAndRemovePowerUp = SKAction.sequence([showPowerUp, removePowerUp])
        
        return showAndRemovePowerUp
    }
    
    
    //Method that call the timer for the player health power up
    func createPowerUpHealth() {
        
        if hitCount > 0 {
            powerUpHealthTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(GameScene.createHealth), userInfo: nil, repeats: true)
        }
    }
    
    
    //Method creates the power up for the Health Icon to appear
    func createHealth () {
        
        powerUpHealth = SKSpriteNode(texture: spriteSheet.PowerUpHealth())
        powerUpHealth.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        powerUpHealth.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.PowerUpHealth().size())
        powerUpHealth.physicsBody?.dynamic = false
        powerUpHealth.physicsBody?.allowsRotation = false
        
        powerUpHealth.physicsBody?.categoryBitMask = CollisionType.HealthPowerUp.rawValue
        powerUpHealth.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        powerUpHealth.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        powerUpHealth.runAction(movePowerUp())
        self.addChild(powerUpHealth)
        
    }
    
    
    //Method creates the power up for the Focus Icon to appear
    func createFocus() {
        
        powerUpFocus = SKSpriteNode(texture: spriteSheet.PowerUpFocus())
        powerUpFocus.position = CGPoint(x: variousXPoints(), y: CGRectGetMaxY(self.frame))
        powerUpFocus.physicsBody = SKPhysicsBody(rectangleOfSize: spriteSheet.PowerUpFocus().size())
        powerUpFocus.physicsBody?.dynamic = false
        powerUpFocus.physicsBody?.allowsRotation = false
        
        powerUpFocus.physicsBody?.categoryBitMask = CollisionType.FocusPowerUp.rawValue
        powerUpFocus.physicsBody?.contactTestBitMask = CollisionType.PlayerShip.rawValue
        powerUpFocus.physicsBody?.collisionBitMask = CollisionType.Object.rawValue
        
        powerUpFocus.runAction(movePowerUp())
        self.addChild(powerUpFocus)
        
    }
    
    //Method creates the focus power up. After the player shoots 20 times a power up will appear for the player to collect in order to use the complete power up to slow the game down.
    func createPowerUpFocus() {
        
        if shotCount == 20 {
            
            powerUpFocusTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.createFocus), userInfo: nil, repeats: false)
            
            shotCount = 0
        }
    }
    
    
    //MARK: HUD
    //Method is used to create the HUD for the game
    func showHUD () {
        
        //Create the container that will hold the info for the player. Create it as a sprite node, anchor it in the center of the scene, set the zPosition so that all the other sprites will appear behind it and set the position to the left of the scene and to the top by subtracting the height of the hub from the height of the scene. Add it to the scene.
        let hudContainer = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.frame.width, self.frame.height * 0.05))
        hudContainer.name = "HUD"
        hudContainer.anchorPoint = CGPointMake(0, 0)
        hudContainer.zPosition = 2.0
        hudContainer.position = CGPointMake(0, self.size.height - hudContainer.size.height)
        allObjects.addChild(hudContainer)

        
        
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
        enemyShipBlack1Timer.invalidate()
        enemyShipBlack2Timer.invalidate()
        enemyShipBlack3Timer.invalidate()
        enemyShipBlack4Timer.invalidate()
        enemyShipBlack5Timer.invalidate()
        meteor1Timer.invalidate()
        meteor2Timer.invalidate()
        meteor3Timer.invalidate()
        meteor4Timer.invalidate()
        meteor5Timer.invalidate()
        meteor6Timer.invalidate()
        meteor7Timer.invalidate()
        meteor8Timer.invalidate()
        exPtsTimer.invalidate()
        fireButton.userInteractionEnabled = false
        
        let alert = UIAlertController(title: "Space Runner", message: "Game Paused", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Continue Playing", style: UIAlertActionStyle.Default) { _ in
            self.view?.paused = false
            self.runEnemyShipTimer()
            self.runMeteorTimer()
            self.createExPoints()
            self.fireButton.userInteractionEnabled = true
            })
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: Game Over Function
    func gameOver () {
        
        collectedPoints = collectedPoints + exPoints
        
        let alert = UIAlertController(title: "Space Runner", message: "Game Over" + "\n" + "You've gained \(collectedPoints) experience points. Use them wisely.", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default) { _ in
            self.allObjects.removeAllChildren()
            self.finalScore = self.playerScore
            self.playerScore = 0
            self.hitCount = 0
            self.exPoints = 0
            self.fireButton.userInteractionEnabled = false
            self.pauseButton.userInteractionEnabled = false
            self.rain?.paused = false
            self.createPlayerShip()
            self.runMeteorTimer()
            self.runEnemyShipTimer()
            self.runExPointsTimer()
            self.showHUD()
            self.focusBkg.removeAllChildren()
            self.shotCount = 0
            self.enemiesDestroyed = 0
            self.speed = 1
            })
        
        alert.addAction(UIAlertAction(title: "Menu", style: UIAlertActionStyle.Default) { _ in
            self.allObjects.removeFromParent()
            self.allObjects.removeAllChildren()
            self.playerShip.removeAllChildren()
            self.focusBkg.removeAllChildren()
            self.playerScore = 0
            self.hitCount = 0
            self.exPoints = 0
            self.shotCount = 0
            self.enemiesDestroyed = 0
            self.fireButton.removeFromParent()
            self.rain?.paused = false
            NSUserDefaults.standardUserDefaults().setObject(collectedPoints, forKey: "experiencePoints")
            self.scheduleNotification()
            self.showMenu()
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
        let focusReady = SKAction.animateWithTextures(spriteSheet.Focus(), timePerFrame: 0.2)
        let focusRepeat = SKAction.repeatActionForever(focusReady)
        
        
        //Method runs add one when the player's ship has been hit/damaged
        func playerShipHit () {
            
            hitCount = hitCount + 1
            
            if hitCount == 1 {
                createPowerUpHealth()
            }
            
        }
        
        //Method checks the players score if it's 0 stay at 0 if not deduct points
        func minusPoints() {
            
            if playerScore <= 0 {
                
                playerScore = 0
                
            } else {
                
                playerScore = playerScore - 20
            }
            
        }
        
        
        //Method runs when the game is over
        func endGame() {
            playerShip.removeAllChildren()
            playerShip.runAction(playerExplodeAndFade)
            enemyLaser.removeFromParent()
            runAction(playerBlownUp)
            enemyShipBlack1Timer.invalidate()
            enemyShipBlack2Timer.invalidate()
            enemyShipBlack3Timer.invalidate()
            enemyShipBlack4Timer.invalidate()
            enemyShipBlack5Timer.invalidate()
            meteor1Timer.invalidate()
            meteor2Timer.invalidate()
            meteor3Timer.invalidate()
            meteor4Timer.invalidate()
            meteor5Timer.invalidate()
            meteor6Timer.invalidate()
            meteor7Timer.invalidate()
            meteor8Timer.invalidate()
            powerUpHealthTimer.invalidate()
            exPtsTimer.invalidate()
            fireButton.userInteractionEnabled = true
            pauseButton.userInteractionEnabled = true
            rain?.paused = true
            _ = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GameScene.gameOver), userInfo: nil, repeats: false)
        }
        
        //Method that builds the focus button
        func buildFocus() {
            
            focusCount = focusCount + 1
            
            print(focusCount)
            
        }
        
        //Declare variables to hold the contact bodies that will cause a action when there is contact between two different entities
        let firstBody: SKPhysicsBody = contact.bodyA
        let secondBody: SKPhysicsBody = contact.bodyB
        
        //Condidtional to check if the player's ship touches a enemy ship
        if (firstBody.categoryBitMask == CollisionType.PlayerShip.rawValue && secondBody.categoryBitMask == CollisionType.Object.rawValue) || (firstBody.categoryBitMask == CollisionType.Object.rawValue && secondBody.categoryBitMask == CollisionType.PlayerShip.rawValue) {
            
            playerShipHit()
            
            
            if firstBody.node!.name == "enemyShipBlack1" || secondBody.node!.name == "enemyShipBlack1" {
                enemyBlack1.runAction(enemyExplodeAndFade)
                minusPoints()
            } else if firstBody.node!.name == "enemyShipBlack2" || secondBody.node!.name == "enemyShipBlack2" {
                enemyBlack2.runAction(enemyExplodeAndFade)
                minusPoints()
            } else if firstBody.node!.name == "enemyShipBlack3" || secondBody.node!.name == "enemyShipBlack3" {
                enemyBlack3.runAction(enemyExplodeAndFade)
                minusPoints()
            } else if firstBody.node!.name == "enemyShipBlack4" || secondBody.node!.name == "enemyShipBlack4" {
                enemyBlack4.runAction(enemyExplodeAndFade)
                minusPoints()
            } else if firstBody.node!.name == "enemyShipBlack5" || secondBody.node!.name == "enemyShipBlack5" {
                enemyBlack5.runAction(enemyExplodeAndFade)
                minusPoints()
            } else if firstBody.node!.name == "Meteor" || secondBody.node!.name == "Meteor" {
                minusPoints()
            }
            
            
            switch hitCount {
            case 1 :
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage1)
            case 2:
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage2)
            case 3:
                runAction(enemyBlownUp)
                playerShip.addChild(shipDamage3)
            default:
                endGame()
            }
        }
        
        //Use a conditional to check if the laser hit a enemy ship
        if firstBody.categoryBitMask == CollisionType.Object.rawValue && secondBody.categoryBitMask == CollisionType.Laser.rawValue || firstBody.categoryBitMask == CollisionType.Laser.rawValue && secondBody.categoryBitMask == CollisionType.Object.rawValue {
            
            
            if firstBody.node!.name == "enemyShipBlack1" || secondBody.node!.name == "enemyShipBlack1" {
                enemyBlack1.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 5
                enemiesDestroyed = enemiesDestroyed + 1
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            } else if firstBody.node!.name == "enemyShipBlack2" || secondBody.node!.name == "enemyShipBlack2" {
                enemyBlack2.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 9
                enemiesDestroyed = enemiesDestroyed + 1
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            } else if firstBody.node!.name == "enemyShipBlack3" || secondBody.node!.name == "enemyShipBlack3" {
                enemyBlack3.runAction(enemyExplodeAndFade)
                playerScore = playerScore + 14
                enemiesDestroyed = enemiesDestroyed + 1
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            } else if firstBody.node!.name == "enemyShipBlack4" || secondBody.node!.name == "enemyShipBlack4"{
                enemyBlack4.runAction(enemyExplodeAndFade)
                enemiesDestroyed = enemiesDestroyed + 1
                playerScore = playerScore + 20
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            }else if firstBody.node!.name == "enemyShipBlack5" || secondBody.node!.name == "enemyShipBlack5"{
                enemyBlack5.runAction(enemyExplodeAndFade)
                enemiesDestroyed = enemiesDestroyed + 1
                playerScore = playerScore + 24
                runAction(enemyBlownUp)
                playerLaser.removeFromParent()
            }else if firstBody.node!.name == "Meteor" || secondBody.node!.name == "Meteor" {
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
                playerScore = playerScore + 10
            case 2:
                shipDamage2.removeFromParent()
                powerUpHealth.removeFromParent()
                runAction(playerHealthAudio)
                hitCount = hitCount - 1
                playerScore = playerScore + 25
            case 3:
                shipDamage3.removeFromParent()
                powerUpHealth.removeFromParent()
                runAction(playerHealthAudio)
                hitCount = hitCount - 1
                playerScore = playerScore + 40
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
               endGame()
            }
            
        }
        
        
        //Conditional statement to check if the player ship contacts a power up. If so remove the power up and alert the player by audio and add the power up
        if (firstBody.categoryBitMask == CollisionType.PlayerShip.rawValue && secondBody.categoryBitMask == CollisionType.FocusPowerUp.rawValue) || (firstBody.categoryBitMask == CollisionType.FocusPowerUp.rawValue && secondBody.categoryBitMask == CollisionType.PlayerShip.rawValue) {
            
            runAction(playerHealthAudio)
            powerUpFocus.removeFromParent()
            
            //Call the method to build the focus button
            buildFocus()
            
            
            switch focusCount {
            case 1:
                focus1 = SKSpriteNode(texture: spriteSheet.Focus1())
                focusBkg.addChild(focus1)
            case 2:
                focus2 = SKSpriteNode(texture: spriteSheet.Focus2())
                focusBkg.addChild(focus2)
            case 3:
                focus3 = SKSpriteNode(texture: spriteSheet.Focus3())
                focusBkg.addChild(focus3)
            case 4:
                focus4 = SKSpriteNode(texture: spriteSheet.Focus4())
                focusBkg.addChild(focus4)
            case 5:
                focus5 = SKSpriteNode(texture: spriteSheet.Focus5())
                focusBkg.addChild(focus5)
            case 6:
                focus6 = SKSpriteNode(texture: spriteSheet.Focus6())
                focusBkg.removeAllChildren()
                focusBkg.runAction(focusRepeat)
            default:
                print("We're focused")
                
            }
        }
    }
    
    
}
