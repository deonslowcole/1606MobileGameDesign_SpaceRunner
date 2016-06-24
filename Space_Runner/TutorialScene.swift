//
//  TutorialScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 6/22/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {

    var instructions = SKSpriteNode()
    var menu = SKSpriteNode()
    var menu2 = SKSpriteNode()
    
    //Create node for Audio
    let close = SKAction.playSoundFileNamed("SpaceDoorClose.mp3", waitForCompletion: true)
    
    
    override func didMoveToView(view: SKView) {
        
        let instrucTexture = SKTexture(imageNamed: "Instructions.png")
        instructions = SKSpriteNode(texture: instrucTexture)
        instructions.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        instructions.size.height = self.frame.height
        instructions.size.width = self.frame.width
        self.addChild(instructions)
        
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
