//
//  AboutScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/21/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class AboutScene: SKScene {
    
    //Create Label nodes for the text that will hold credit info for the game
    var devLabel = SKLabelNode()
    var nameLabel = SKLabelNode()
    var assestLabel = SKLabelNode()
    var assestNameLabel = SKLabelNode()
    var audioLabel = SKLabelNode()
    var audioNameLabel1 = SKLabelNode()
    var audioNameLabel2 = SKLabelNode()
    var audioNameLabel3 = SKLabelNode()
    
    var menu = SKSpriteNode()
    var menu2 = SKSpriteNode()
    
    //Create node for Audio
    let close = SKAction.playSoundFileNamed("SpaceDoorClose.mp3", waitForCompletion: true)
    

    override func didMoveToView(view: SKView) {
        
        //Set the background color
        self.backgroundColor = SKColor(red: 0.51, green: 0.10, blue: 0.15, alpha: 1.0)
        
        //set info for each of the label nodes
        devLabel.position = CGPointMake(self.size.width / 2, self.size.height - 200)
        devLabel.text = "Developer:"
        devLabel.fontSize = 100.0
        devLabel.fontColor = UIColor.whiteColor()
        self.addChild(devLabel)
        
        nameLabel.position = CGPointMake(self.size.width / 2, devLabel.position.y - 150)
        nameLabel.text = "Deonslow Cole"
        nameLabel.fontSize = 150.0
        nameLabel.fontColor = UIColor.whiteColor()
        self.addChild(nameLabel)
        
        
        assestLabel.position = CGPointMake(self.size.width / 2, nameLabel.position.y - 300)
        assestLabel.text = "Assests By:"
        assestLabel.fontSize = 100.0
        assestLabel.fontColor = UIColor.whiteColor()
        self.addChild(assestLabel)
        
        assestNameLabel.position = CGPointMake(self.size.width / 2, assestLabel.position.y - 150)
        assestNameLabel.text = "kenney.nl"
        assestNameLabel.fontSize = 150.0
        assestNameLabel.fontColor = UIColor.whiteColor()
        self.addChild(assestNameLabel)
        
        
        audioLabel.position = CGPointMake(self.size.width / 2, assestNameLabel.position.y - 300)
        audioLabel.text = "Sound Effects & Music By:"
        audioLabel.fontSize = 90.0
        audioLabel.fontColor = UIColor.whiteColor()
        self.addChild(audioLabel)
        
        audioNameLabel1.position = CGPointMake(self.size.width / 2, audioLabel.position.y - 150)
        audioNameLabel1.text = "kenny.nl"
        audioNameLabel1.fontSize = 90.0
        audioNameLabel1.fontColor = UIColor.whiteColor()
        self.addChild(audioNameLabel1)
        
        audioNameLabel2.position = CGPointMake(self.size.width / 2, audioNameLabel1.position.y - 150)
        audioNameLabel2.text = "Sound Ideas"
        audioNameLabel2.fontSize = 80.0
        audioNameLabel2.fontColor = UIColor.whiteColor()
        self.addChild(audioNameLabel2)
        
        audioNameLabel3.position = CGPointMake(self.size.width / 2, audioNameLabel2.position.y - 150)
        audioNameLabel3.text = "Westar Music"
        audioNameLabel3.fontSize = 90.0
        audioNameLabel3.fontColor = UIColor.whiteColor()
        self.addChild(audioNameLabel3)
        
        
        //Create texture & node for the menu to allow users to go back
        let menuTexture = SKTexture(imageNamed: "MenuButton.png")
        menu = SKSpriteNode(texture: menuTexture)
        menu.name = "Menu"
        menu.position = CGPointMake(self.size.width / 2, audioNameLabel3.position.y - 300)
        
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
        
        for touch in touches {
            
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
                    self.scene?.view?.presentScene(gameScene, transition: transition)
                }
                
                
            }
        }
        
    }
    
}
