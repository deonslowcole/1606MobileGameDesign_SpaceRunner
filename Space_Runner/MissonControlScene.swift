//
//  MissonControlScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/8/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class MissonControlScene: SKScene {
    
    var menu = SKSpriteNode()
    var menu2 = SKSpriteNode()
    var mcBkg = SKSpriteNode()
    var xpCountLabel = SKLabelNode()
    var xpCover1 = SKSpriteNode()
    var xpCover2 = SKSpriteNode()
    var xpCover3 = SKSpriteNode()
    var xp1 = SKSpriteNode()
    var xp2 = SKSpriteNode()
    var xp3 = SKSpriteNode()
    var xp4 = SKSpriteNode()
    var xp1Label = SKLabelNode()
    var xp2Label = SKLabelNode()
    var xp3Label = SKLabelNode()
    var xp4Label = SKLabelNode()
    
    //Create bools for if the player owns a particulair ship
    var xp1IsOwned = true
    var xp2IsOwned = false
    var xp3IsOwned = false
    var xp4IsOwned = false
    
    //Declare variables to hold if the player ship is owned or equipped.
    var xp1String = String()
    var xp2String = String()
    var xp3String = String()
    var xp4String = String()
    
    
    //Create a HUD node to display the amount of XP available
    var hudContainer = SKSpriteNode()
    
    
    //Create node for Audio
    let close = SKAction.playSoundFileNamed("SpaceDoorClose.mp3", waitForCompletion: true)
    
    //Declare a variable to hold the name of the ship that the player chooses.
    var chosenShip = String()
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        let mcBkgTexture = SKTexture(imageNamed: "OrangeBackground")
        mcBkg = SKSpriteNode(texture: mcBkgTexture)
        mcBkg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        mcBkg.zPosition = -1.0
        mcBkg.size.height = self.frame.height
        mcBkg.size.width = self.frame.width
        self.addChild(mcBkg)
        
        hudContainer = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.frame.width, self.frame.height * 0.1))
        hudContainer.name = "HUD"
        hudContainer.anchorPoint = CGPointMake(0, 0)
        hudContainer.position = CGPointMake(0, self.size.height - hudContainer.size.height)
        self.addChild(hudContainer)
        
        //Call the method to show what the player can spend their xp on.
        showNewShips()
        
        //set info for the xpLabel node
        xpCountLabel.position = CGPointMake(hudContainer.size.width / 2, hudContainer.size.height / 2)
        xpCountLabel.text = "Available To Spend: \(collectedPoints) xp"
        xpCountLabel.fontSize = 55.0
        xpCountLabel.fontName = "Menlo"
        xpCountLabel.fontColor = UIColor.blackColor()
        hudContainer.addChild(xpCountLabel)
        
        
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
                
                if name == "XP1" {
                    
                    pickShip(name)
                    
                } else if name == "XP2" {
                    if xp2IsOwned == false {
                        getShip(name)
                    } else {
                        pickShip(name)
                    }
                    
                } else if name == "XP3" {
                    if xp3IsOwned == false {
                        getShip(name)
                    } else {
                        pickShip(name)
                    }
                    
                } else if name == "XP4" {
                    if xp4IsOwned == false {
                        getShip(name)
                    } else {
                        pickShip(name)
                    }
                    
                } else if name == "Menu" {
                    let gameScene = GameScene(size: self.size)
                    let transition = SKTransition.doorsCloseHorizontalWithDuration(0.8)
                    gameScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(close)
                    //Save the information so that when the player returns it will remain the same.
                    NSUserDefaults.standardUserDefaults().setObject(xp1IsOwned, forKey: "redShipOwned")
                    NSUserDefaults.standardUserDefaults().setObject(xp2IsOwned, forKey: "blueShipOwned")
                    NSUserDefaults.standardUserDefaults().setObject(xp3IsOwned, forKey: "greenShipOwned")
                    NSUserDefaults.standardUserDefaults().setObject(xp3IsOwned, forKey: "orangeShipOwned")
                    NSUserDefaults.standardUserDefaults().setObject(xp1Label.text, forKey: "redString")
                    NSUserDefaults.standardUserDefaults().setObject(xp2Label.text, forKey: "blueString")
                    NSUserDefaults.standardUserDefaults().setObject(xp3Label.text, forKey: "greenString")
                    NSUserDefaults.standardUserDefaults().setObject(xp4Label.text, forKey: "orangeString")
                    NSUserDefaults.standardUserDefaults().setObject(chosenShip, forKey: "theShip")
                    self.scene?.view?.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
    
    
    //MARK: Functions
    //Method shows what players xp can be spent on.
    func showNewShips() {
        
        //Create nodes to add disable effect so that the user can not touch them and purchase them mistakenly
        xpCover1 = SKSpriteNode(texture: spriteSheet.cruiserUnchecked())
        xpCover1.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        xpCover2 = SKSpriteNode(texture: spriteSheet.cruiserUnchecked())
        xpCover2.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        xpCover3 = SKSpriteNode(texture: spriteSheet.cruiserUnchecked())
        xpCover3.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        
        
        //Set up nodes for the player to choose one of the ships using their xp Points
        xp1 = SKSpriteNode(texture: spriteSheet.cruiserRed())
        xp1.name = "XP1"
        xp1.position = CGPointMake(self.frame.width / 2, hudContainer.position.y - 200)
        xp1.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        self.addChild(xp1)
        
        xp1Label.position = CGPointMake(self.frame.width / 2, xp1.position.y - 120)

        if xp1IsOwned == true {
            if let xp1Text = NSUserDefaults.standardUserDefaults().objectForKey("redString") {
                xp1Label.text = xp1Text as? String
            } else {
                xp1Label.text = "Equipped"
            }
        }
        xp1Label.fontSize = 60.0
        xp1Label.fontName = "Menlo"
        xp1Label.fontColor = UIColor.blackColor()
        self.addChild(xp1Label)
        
        
        xp2 = SKSpriteNode(texture: spriteSheet.cruiserBlue())
        xp2.name = "XP2"
        xp2.position = CGPointMake(self.frame.width / 2, xp1Label.position.y - 200)
        xp2.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        xp2.addChild(xpCover1)
        self.addChild(xp2)
        
        //Set the position of the labels to display how much each item cost. If it is already owned show the status either owned or equipped. If not owned show the xp cost. If owned show the if it is equipped or not and remove the children so that the player can interact with it.
        xp2Label.position = CGPointMake(self.frame.width / 2, xp2.position.y - 120)
        if let ownBlue = NSUserDefaults.standardUserDefaults().objectForKey("blueShipOwned") {
            xp2IsOwned = ownBlue as! Bool
        }
        
        if xp2IsOwned == false {
            xp2Label.text = "500xp"
        } else {
            
            xp2Label.text = String(NSUserDefaults.standardUserDefaults().objectForKey("blueString")!)
            xp2.removeAllChildren()
        }
        
        xp2Label.fontSize = 60.0
        xp2Label.fontName = "Menlo"
        xp2Label.fontColor = UIColor.blackColor()
        self.addChild(xp2Label)
        
        
        xp3 = SKSpriteNode(texture: spriteSheet.cruiserGreen())
        xp3.name = "XP3"
        xp3.position = CGPointMake(self.frame.width / 2, xp2Label.position.y - 200)
        xp3.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        xp3.addChild(xpCover2)
        self.addChild(xp3)
        
        xp3Label.position = CGPointMake(self.frame.width / 2, xp3.position.y - 120)
        if let ownGreen = NSUserDefaults.standardUserDefaults().objectForKey("greenShipOwned") {
            xp3IsOwned = ownGreen as! Bool
        }
        
        if xp3IsOwned == false {
            xp3Label.text = "1000xp"
        } else {
            
            xp3Label.text = String(NSUserDefaults.standardUserDefaults().objectForKey("greenString")!)
            xp3.removeAllChildren()
        }
        xp3Label.fontSize = 60.0
        xp3Label.fontName = "Menlo"
        xp3Label.fontColor = UIColor.blackColor()
        self.addChild(xp3Label)
        
        
        xp4 = SKSpriteNode(texture: spriteSheet.cruiserOrange())
        xp4.name = "XP4"
        xp4.position = CGPointMake(self.frame.width / 2, xp3Label.position.y - 200)
        xp4.size = CGSizeMake(self.frame.width / 1.5, self.frame.height / 15)
        xp4.addChild(xpCover3)
        self.addChild(xp4)
        
        xp4Label.position = CGPointMake(self.frame.width / 2, xp4.position.y - 120)
        if let ownOrange = NSUserDefaults.standardUserDefaults().objectForKey("orangeShipOwned") {
            xp4IsOwned = ownOrange as! Bool
        }
        
        if xp4IsOwned == false {
            xp4Label.text = "1500xp"
        } else {
            
            xp4Label.text = String(NSUserDefaults.standardUserDefaults().objectForKey("orangeString")!)
            xp4.removeAllChildren()
        }
        xp4Label.fontSize = 60.0
        xp4Label.fontName = "Menlo"
        xp4Label.fontColor = UIColor.blackColor()
        self.addChild(xp4Label)
        
        //Use a conditional to check if the player has already purchased the ship. If it isn't owned run the method to check the amount of xp so that the player can purchase a ship.
        if xp2IsOwned == false {
            xpCheck()
        }
        
        if xp3IsOwned == false {
            xpCheck()
        }
        
        if xp4IsOwned == false {
            xpCheck()
        }
        
    }
    
    //Method for Checking the amount of xp for player to buy a new ship
    func xpCheck() {
        
        switch collectedPoints {
        case 500...999:
            xp2.removeAllChildren()
        case 1000...1499:
            xp2.removeAllChildren()
            xp3.removeAllChildren()
        case 1500...999999:
            xp2.removeAllChildren()
            xp3.removeAllChildren()
            xp4.removeAllChildren()
        default:
            break
        }
    }
    
    
    //Method for spending xp. Use an alert to confirm if the player wants to spend the needed xp. Pass the name of the touched node as a parameter. If the player comfirms spending the xp set the ship owned as true deduct the necessary xp points, set the label to the new purchase as well as the labels to the others if they have been purchased.
    func getShip(name: String) {
        
        let alert = UIAlertController(title: "Space Runner", message: "Do you want to spend XP?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { _ in})
        
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default) { _ in
            
            if name == "XP1" {
            
                self.xp1IsOwned = true
                
            } else if name == "XP2" {
                self.xp2IsOwned = true
                collectedPoints = collectedPoints - 500
                self.xpCountLabel.text = "Available To Spend: \(collectedPoints) xp"
                self.xp1Label.text = "Owned"
                self.xp1String = "Owned"
                self.xp2Label.text = "Equipped"
                self.xp2String = "Equipped"
                if self.xp3IsOwned == true {
                    self.xp3Label.text = "Owned"
                    self.xp3String = "Owned"
                }
                if self.xp4IsOwned == true {
                    self.xp4Label.text = "Owned"
                    self.xp4String = "Owned"
                }
                self.chosenShip = "playerShipBlue"
            } else if name == "XP3" {
                self.xp3IsOwned = true
                collectedPoints = collectedPoints - 1000
                self.xpCountLabel.text = "Available To Spend: \(collectedPoints) xp"
                self.xp1Label.text = "Owned"
                self.xp1String = "Owned"
                if self.xp2IsOwned == true {
                    self.xp2Label.text = "Owned"
                    self.xp2String = "Owned"
                }
                self.xp3Label.text = "Equipped"
                self.xp3String = "Equipped"
                if self.xp4IsOwned == true {
                    self.xp4Label.text = "Owned"
                    self.xp4String = "Owned"
                }
                self.chosenShip = "playerShipGreen"
            } else if name == "XP4" {
                self.xp4IsOwned = true
                collectedPoints = collectedPoints - 1500
                self.xpCountLabel.text = "Available To Spend: \(collectedPoints) xp"
                self.xp1Label.text = "Owned"
                self.xp1String = "Owned"
                if self.xp2IsOwned == true {
                    self.xp2Label.text = "Owned"
                    self.xp2String = "Owned"
                }
                if self.xp3IsOwned == true {
                    self.xp3Label.text = "Owned"
                    self.xp3String = "Owned"
                }
                self.xp4Label.text = "Equipped"
                self.xp4String = "Equipped"
                self.chosenShip = "playerShipOrange"
            }
            
            })
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Method that changes the labels to notify the player which one they have equpppied against the ones that they own.
    func pickShip(name: String){
        
        if name == "XP1" {
            xp1Label.text = "Equipped"
            
            if xp2IsOwned == true {
                
                xp2Label.text = "Owned"
                
            }
            
            if xp3IsOwned == true {
                
                xp3Label.text = "Owned"
                
            }
            
            if xp4IsOwned == true {
                
                xp4Label.text = "Owned"
            }
            
            chosenShip = "playerShipRed"
        }
        
        if name == "XP2" {
            xp2Label.text = "Equipped"
            
            if xp1IsOwned == true {
                
                xp1Label.text = "Owned"
                
            }
            
            if xp3IsOwned == true {
                
                xp3Label.text = "Owned"
                
            }
            
            if xp4IsOwned == true {
                
                xp4Label.text = "Owned"
            }
            
            chosenShip = "playerShipBlue"
        }
        
        if name == "XP3" {
            xp3Label.text = "Equipped"
            
            if xp1IsOwned == true {
                
                xp1Label.text = "Owned"
                
            }
            
            if xp2IsOwned == true {
                
                xp2Label.text = "Owned"
                
            }
            
            if xp4IsOwned == true {
                
                xp4Label.text = "Owned"
            }
            
            chosenShip = "playerShipGreen"
        }
        
        
        if name == "XP4" {
            xp4Label.text = "Equipped"
            
            if xp1IsOwned == true {
                
                xp1Label.text = "Owned"
                
            }
            
            if xp2IsOwned == true {
                
                xp2Label.text = "Owned"
                
            }
            
            if xp3IsOwned == true {
                
                xp3Label.text = "Owned"
            }
            
            chosenShip = "playerShipOrange"
        }
        
    }

}
