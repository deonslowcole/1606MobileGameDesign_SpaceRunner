//
//  AchievementScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/25/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import SpriteKit

class AchievementScene: SKScene {
    
    
    //Declare a variable for the backbground node
    var achBkg = SKSpriteNode()
    
    //Create a HUD node to display the amount of XP available
    var hudContainer = SKSpriteNode()
    var titleLabel = SKLabelNode()
    
    //Create huds, nodes & label for the first achievements
    var achieveHud1 = SKSpriteNode()
    var achieveHud1Bottom = SKSpriteNode()
    var enemyDestroyedAch1 = SKSpriteNode()
    var enemyDestroyedAch2 = SKSpriteNode()
    var enemyDestroyedAch3 = SKSpriteNode()
    var enemyDestAchCover1 = SKSpriteNode()
    var enemyDestAchCover2 = SKSpriteNode()
    var enemyDestAchCover3 = SKSpriteNode()
    var enemyDestAchLabel = SKLabelNode()
    
    //Create huds, nodes & label for the second achievements
    var achieveHud2 = SKSpriteNode()
    var achieveHud2Bottom = SKSpriteNode()
    var enemyBeforeDmgAch1 = SKSpriteNode()
    var enemyBeforeDmgAch2 = SKSpriteNode()
    var enemyBeforeDmgAch3 = SKSpriteNode()
    var enemyBfreDmgAchCover1 = SKSpriteNode()
    var enemyBfreDmgAchCover2 = SKSpriteNode()
    var enemyBfreDmgAchCover3 = SKSpriteNode()
    var enemyBfreDmgAchLabel = SKLabelNode()
    
    //Create huds, nodes & label for the second achievements
    var achieveHud3 = SKSpriteNode()
    var achieveHud3Bottom = SKSpriteNode()
    var surviveAch1 = SKSpriteNode()
    var surviveAch2 = SKSpriteNode()
    var surviveAch3 = SKSpriteNode()
    var surviveAchCover1 = SKSpriteNode()
    var surviveAchCover2 = SKSpriteNode()
    var surviveAchCover3 = SKSpriteNode()
    var surviveAchLabel = SKLabelNode()
    
    //Create huds, nodes & label for the second achievements
    var achieveHud4 = SKSpriteNode()
    var achieveHud4Bottom = SKSpriteNode()
    var enhanceAch1 = SKSpriteNode()
    var enhanceAch2 = SKSpriteNode()
    var enhanceAch3 = SKSpriteNode()
    var enhanceAchCover1 = SKSpriteNode()
    var enhanceAchCover2 = SKSpriteNode()
    var enhanceAchCover3 = SKSpriteNode()
    var enhanceAchLabel = SKLabelNode()
    
    //Create node for going back to the menu scene
    var menu = SKSpriteNode()
    var menu2 = SKSpriteNode()
    

    
    override func didMoveToView(view: SKView) {
        
        //Create for background and add it to the scene
        let achBkgTexture = SKTexture(imageNamed: "OrangeBackground")
        achBkg = SKSpriteNode(texture: achBkgTexture)
        achBkg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        achBkg.zPosition = -1.0
        achBkg.size.height = self.frame.height
        achBkg.size.width = self.frame.width
        self.addChild(achBkg)
        
        
        hudContainer = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.frame.width, self.frame.height * 0.07))
        hudContainer.name = "HUD"
        hudContainer.anchorPoint = CGPointMake(0, 0)
        hudContainer.position = CGPointMake(0, self.size.height - hudContainer.size.height)
        self.addChild(hudContainer)
        
        //set info for the hud titleLabel node
        titleLabel.position = CGPointMake(hudContainer.size.width / 2, hudContainer.size.height / 4)
        titleLabel.text = "Achievements"
        titleLabel.fontSize = 75.0
        titleLabel.fontName = "Menlo"
        titleLabel.fontColor = UIColor.blackColor()
        hudContainer.addChild(titleLabel)
        
        
        //Call the methods to create the achievements
        enemyDestroyedAchievement()
        enemyBeforeDamage()
        survivalTimeAchievement()
        enhancerAchievement()
        
        
        //Call the methods to check the achievements of the player
        enemyDestCheck()
        enemyDestBfDamageCheck()
        survivalTimeCheck()
        enhancerCountCheck()
        
        
        //Create texture & node for the menu to allow users to go back
        let menuTexture = SKTexture(imageNamed: "MenuButton.png")
        menu = SKSpriteNode(texture: menuTexture)
        menu.name = "Menu"
        menu.zPosition = 2.0
        menu.position = CGPointMake(self.size.width / 2, 100)
        
        //Create texture for the second menu node
        let menu2Texture = SKTexture(imageNamed: "MenuButton2.png")
        menu2 = SKSpriteNode(texture: menu2Texture)
        
        //Create action to animate the two menu nodes to alert the player. Add the menu button to the scene
        let menuFlash = SKAction.animateWithTextures([menu2Texture, menuTexture], timePerFrame: 0.5)
        let keepFlashing = SKAction.repeatActionForever(menuFlash)
        menu.runAction(keepFlashing)
        self.addChild(menu)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            //Declare a constant to hold the location of the touch
            let location = touch.locationInNode(self)
            
            //Declare a constant to hold the node that is touched at the location
            let touchedNode = self.nodeAtPoint(location)
            
            print(touchedNode)
            
            //Use optional binding to check the name of the touched node. If there is a name use a conditional to check for the name and go back to the original starting point
            if let name = touchedNode.name {
                
                if name == "Menu" {
                    let gameScene = GameScene(size: self.size)
                    let transition = SKTransition.doorsCloseHorizontalWithDuration(0.8)
                    gameScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(close)
                    //                    //Save the information so that when the player returns it will remain the same.
                    //                    NSUserDefaults.standardUserDefaults().setObject(xp1IsOwned, forKey: "redShipOwned")
                    self.scene?.view?.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
    
    
    
    //MARK: Achievement Functions
    //Method for creating the achievement for the number of enemies destroyed
    func enemyDestroyedAchievement() {
        achieveHud1 = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.frame.width, self.frame.height / 10))
        achieveHud1.position = CGPointMake(self.frame.width / 2, hudContainer.position.y - 200)
        //achieveHud1.zPosition = -1
        self.addChild(achieveHud1)
        
        achieveHud1Bottom = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(self.frame.width, self.frame.height / 20))
        achieveHud1Bottom.position = CGPointMake(self.frame.width / 2, achieveHud1.position.y - 145)
        self.addChild(achieveHud1Bottom)
        
        enemyDestAchCover1 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyDestAchCover1.size = CGSizeMake(150, 150)
        
        enemyDestAchCover2 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyDestAchCover2.size = CGSizeMake(150, 150)
        
        enemyDestAchCover3 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyDestAchCover3.size = CGSizeMake(150, 150)
        
        enemyDestroyedAch2 = SKSpriteNode(texture: spriteSheet.Star())
        enemyDestroyedAch2.size = CGSizeMake(150, 150)
        enemyDestroyedAch2.position = CGPointMake(achieveHud1.position.x, achieveHud1.position.y)
        enemyDestroyedAch2.zPosition = 3
        enemyDestroyedAch2.addChild(enemyDestAchCover2)
        self.addChild(enemyDestroyedAch2)
        
        enemyDestroyedAch1 = SKSpriteNode(texture: spriteSheet.Star())
        enemyDestroyedAch1.size = CGSizeMake(150, 150)
        enemyDestroyedAch1.position = CGPointMake(enemyDestroyedAch2.position.x - 175, achieveHud1.position.y)
        enemyDestroyedAch1.zPosition = 3
        enemyDestroyedAch1.addChild(enemyDestAchCover1)
        self.addChild(enemyDestroyedAch1)
        
        enemyDestroyedAch3 = SKSpriteNode(texture: spriteSheet.Star())
        enemyDestroyedAch3.size = CGSizeMake(150, 150)
        enemyDestroyedAch3.position = CGPointMake(enemyDestroyedAch2.position.x + 175, achieveHud1.position.y)
        enemyDestroyedAch3.zPosition = 3
        enemyDestroyedAch3.addChild(enemyDestAchCover3)
        self.addChild(enemyDestroyedAch3)
        
        enemyDestAchLabel.position = CGPointMake(achieveHud1Bottom.size.width / 2, achieveHud1Bottom.position.y - 30)
        enemyDestAchLabel.text = "Destroy 50 Enemy Ships"
        enemyDestAchLabel.fontName = "Menlo"
        enemyDestAchLabel.fontSize = 50
        enemyDestAchLabel.fontColor = UIColor.whiteColor()
        self.addChild(enemyDestAchLabel)
    }
    
    //Method for creating the achievement for the number of enemies destroyed before taking damage
    func enemyBeforeDamage() {
        
        achieveHud2 = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.frame.width, self.frame.height / 10))
        achieveHud2.position = CGPointMake(self.frame.width / 2, achieveHud1Bottom.position.y - 200)
        self.addChild(achieveHud2)
        
        achieveHud2Bottom = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(self.frame.width, self.frame.height / 20))
        achieveHud2Bottom.position = CGPointMake(self.frame.width / 2, achieveHud2.position.y - 145)
        self.addChild(achieveHud2Bottom)
        
        enemyBfreDmgAchCover1 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyBfreDmgAchCover1.size = CGSizeMake(150, 150)
        
        enemyBfreDmgAchCover2 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyBfreDmgAchCover2.size = CGSizeMake(150, 150)
        
        enemyBfreDmgAchCover3 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enemyBfreDmgAchCover3.size = CGSizeMake(150, 150)
        
        enemyBeforeDmgAch2 = SKSpriteNode(texture: spriteSheet.Star())
        enemyBeforeDmgAch2.size = CGSizeMake(150, 150)
        enemyBeforeDmgAch2.position = CGPointMake(achieveHud2.position.x, achieveHud2.position.y)
        enemyBeforeDmgAch2.zPosition = 3
        enemyBeforeDmgAch2.addChild(enemyBfreDmgAchCover2)
        self.addChild(enemyBeforeDmgAch2)
        
        enemyBeforeDmgAch1 = SKSpriteNode(texture: spriteSheet.Star())
        enemyBeforeDmgAch1.size = CGSizeMake(150, 150)
        enemyBeforeDmgAch1.position = CGPointMake(enemyBeforeDmgAch2.position.x - 175, achieveHud2.position.y)
        enemyBeforeDmgAch1.zPosition = 3
        enemyBeforeDmgAch1.addChild(enemyBfreDmgAchCover1)
        self.addChild(enemyBeforeDmgAch1)
        
        enemyBeforeDmgAch3 = SKSpriteNode(texture: spriteSheet.Star())
        enemyBeforeDmgAch3.size = CGSizeMake(150, 150)
        enemyBeforeDmgAch3.position = CGPointMake(enemyBeforeDmgAch2.position.x + 175, achieveHud2.position.y)
        enemyBeforeDmgAch3.zPosition = 3
        enemyBeforeDmgAch3.addChild(enemyBfreDmgAchCover3)
        self.addChild(enemyBeforeDmgAch3)
        
        enemyBfreDmgAchLabel.position = CGPointMake(achieveHud2Bottom.size.width / 2, achieveHud2Bottom.position.y - 30)
        enemyBfreDmgAchLabel.text = "Destroy 60 Enemy Ships Before Taking Damage"
        enemyBfreDmgAchLabel.fontName = "Menlo"
        enemyBfreDmgAchLabel.fontSize = 35
        enemyBfreDmgAchLabel.fontColor = UIColor.whiteColor()
        self.addChild(enemyBfreDmgAchLabel)
        
    }
    
    //Method for creating the achievement for the amount of time survived
    func survivalTimeAchievement(){
        
        achieveHud3 = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.frame.width, self.frame.height / 10))
        achieveHud3.position = CGPointMake(self.frame.width / 2, achieveHud2Bottom.position.y - 200)
        self.addChild(achieveHud3)
        
        achieveHud3Bottom = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(self.frame.width, self.frame.height / 20))
        achieveHud3Bottom.position = CGPointMake(self.frame.width / 2, achieveHud3.position.y - 145)
        self.addChild(achieveHud3Bottom)
        
        surviveAchCover1 = SKSpriteNode(texture: spriteSheet.StarCovered())
        surviveAchCover1.size = CGSizeMake(150, 150)
        
        surviveAchCover2 = SKSpriteNode(texture: spriteSheet.StarCovered())
        surviveAchCover2.size = CGSizeMake(150, 150)
        
        surviveAchCover3 = SKSpriteNode(texture: spriteSheet.StarCovered())
        surviveAchCover3.size = CGSizeMake(150, 150)
        
        surviveAch2 = SKSpriteNode(texture: spriteSheet.Star())
        surviveAch2.size = CGSizeMake(150, 150)
        surviveAch2.position = CGPointMake(achieveHud3.position.x, achieveHud3.position.y)
        surviveAch2.zPosition = 3
        surviveAch2.addChild(surviveAchCover2)
        self.addChild(surviveAch2)
        
        surviveAch1 = SKSpriteNode(texture: spriteSheet.Star())
        surviveAch1.size = CGSizeMake(150, 150)
        surviveAch1.position = CGPointMake(surviveAch2.position.x - 175, achieveHud3.position.y)
        surviveAch1.zPosition = 3
        surviveAch1.addChild(surviveAchCover1)
        self.addChild(surviveAch1)
        
        surviveAch3 = SKSpriteNode(texture: spriteSheet.Star())
        surviveAch3.size = CGSizeMake(150, 150)
        surviveAch3.position = CGPointMake(surviveAch2.position.x + 175, achieveHud3.position.y)
        surviveAch3.zPosition = 3
        surviveAch3.addChild(surviveAchCover3)
        self.addChild(surviveAch3)
        
        surviveAchLabel.position = CGPointMake(achieveHud3Bottom.size.width / 2, achieveHud3Bottom.position.y - 30)
        surviveAchLabel.text = "Survived 3 minutes Before Dying"
        surviveAchLabel.fontName = "Menlo"
        surviveAchLabel.fontSize = 50
        surviveAchLabel.fontColor = UIColor.whiteColor()
        self.addChild(surviveAchLabel)
        
    }
    
    //Method for creating the achievement for the number enhancers collected
    func enhancerAchievement(){
        
        achieveHud4 = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(self.frame.width, self.frame.height / 10))
        achieveHud4.position = CGPointMake(self.frame.width / 2, achieveHud3Bottom.position.y - 200)
        self.addChild(achieveHud4)
        
        achieveHud4Bottom = SKSpriteNode(color: UIColor.grayColor(), size: CGSizeMake(self.frame.width, self.frame.height / 20))
        achieveHud4Bottom.position = CGPointMake(self.frame.width / 2, achieveHud4.position.y - 145)
        self.addChild(achieveHud4Bottom)
        
        enhanceAchCover1 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enhanceAchCover1.size = CGSizeMake(150, 150)
        
        enhanceAchCover2 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enhanceAchCover2.size = CGSizeMake(150, 150)
        
        enhanceAchCover3 = SKSpriteNode(texture: spriteSheet.StarCovered())
        enhanceAchCover3.size = CGSizeMake(150, 150)
        
        enhanceAch2 = SKSpriteNode(texture: spriteSheet.Star())
        enhanceAch2.size = CGSizeMake(150, 150)
        enhanceAch2.position = CGPointMake(achieveHud4.position.x, achieveHud4.position.y)
        enhanceAch2.zPosition = 3
        enhanceAch2.addChild(enhanceAchCover2)
        self.addChild(enhanceAch2)
        
        enhanceAch1 = SKSpriteNode(texture: spriteSheet.Star())
        enhanceAch1.size = CGSizeMake(150, 150)
        enhanceAch1.position = CGPointMake(enhanceAch2.position.x - 175, achieveHud4.position.y)
        enhanceAch1.zPosition = 3
        enhanceAch1.addChild(enhanceAchCover1)
        self.addChild(enhanceAch1)
        
        enhanceAch3 = SKSpriteNode(texture: spriteSheet.Star())
        enhanceAch3.size = CGSizeMake(150, 150)
        enhanceAch3.position = CGPointMake(enhanceAch2.position.x + 175, achieveHud4.position.y)
        enhanceAch3.zPosition = 3
        enhanceAch3.addChild(enhanceAchCover3)
        self.addChild(enhanceAch3)
        
        enhanceAchLabel.position = CGPointMake(achieveHud4Bottom.size.width / 2, achieveHud4Bottom.position.y - 30)
        enhanceAchLabel.text = "Collect 25 Enhancers"
        enhanceAchLabel.fontName = "Menlo"
        enhanceAchLabel.fontSize = 50
        enhanceAchLabel.fontColor = UIColor.whiteColor()
        self.addChild(enhanceAchLabel)
    }
    
    //MARK: Achievement Checks
    
    //Method to check the number of enemies destoyed
    func enemyDestCheck(){
        
        switch totalKills {
        case 0...49:
            enemyDestAchLabel.text = "Destroy 50 Enemy Ships"
        case 50...99:
            enemyDestroyedAch1.removeAllChildren()
            enemyDestAchLabel.text = "Destroy 100 Enemy Ships"
        case 100...149:
            enemyDestroyedAch1.removeAllChildren()
            enemyDestroyedAch2.removeAllChildren()
            enemyDestAchLabel.text = "Destroy 150 Enemy Ships"
        case 150...999999:
            enemyDestroyedAch1.removeAllChildren()
            enemyDestroyedAch2.removeAllChildren()
            enemyDestroyedAch3.removeAllChildren()
            enemyDestAchLabel.text = "Achievement Complete"
        default:
            print("Destroy the enemy ships")
        }
        
    }
    
    
    //Method to check the number of enemies destoyed
    func enemyDestBfDamageCheck(){
        
        switch totalDestroyedBfDamage {
        case 0...59:
            enemyBfreDmgAchLabel.text = "Destroy 60 Enemy Ships"
        case 60...119:
            enemyBeforeDmgAch1.removeAllChildren()
            enemyBfreDmgAchLabel.text = "Destroy 120 Enemy Ships"
        case 120...179:
            enemyBeforeDmgAch1.removeAllChildren()
            enemyBeforeDmgAch2.removeAllChildren()
            enemyBfreDmgAchLabel.text = "Destroy 180 Enemy Ships"
        case 180...999999:
            enemyBeforeDmgAch1.removeAllChildren()
            enemyBeforeDmgAch2.removeAllChildren()
            enemyBeforeDmgAch3.removeAllChildren()
            enemyBfreDmgAchLabel.text = "Achievement Complete"
        default:
            print("Destroyed enemies before dying")
        }
        
    }
    
    
    func survivalTimeCheck() {
        
        switch totalSurvivalTime {
        case 0...179:
            surviveAchLabel.text = "Survived 3 minutes Before Dying"
        case 180...299:
            surviveAch1.removeAllChildren()
            surviveAchLabel.text = "Survived 5 minutes Before Dying"
        case 300...419:
            surviveAch1.removeAllChildren()
            surviveAch2.removeAllChildren()
            surviveAchLabel.text = "Survived 7 minutes Before Dying"
        case 420...999999:
            surviveAch1.removeAllChildren()
            surviveAch2.removeAllChildren()
            surviveAch3.removeAllChildren()
            surviveAchLabel.text = "Achievement Complete"
        default:
            print("Survival Achievement")
        }
        
    }
    
    
    func enhancerCountCheck() {
        
        switch totalEnhancerCount {
        case 0...24:
            enhanceAchLabel.text = "Collect 25 Enhancers"
        case 25...74:
            enhanceAch1.removeAllChildren()
            enhanceAchLabel.text = "Collect 75 Enhancers"
        case 75...149:
            enhanceAch1.removeAllChildren()
            enhanceAch2.removeAllChildren()
            enhanceAchLabel.text = "Collect 150 Enhancers"
        case 150...999999:
            enhanceAch1.removeAllChildren()
            enhanceAch2.removeAllChildren()
            enhanceAch3.removeAllChildren()
            enhanceAchLabel.text = "Achievement Complete"
        default:
            print(" Enhancer Collection Achievement")
        }
        
    }

}
