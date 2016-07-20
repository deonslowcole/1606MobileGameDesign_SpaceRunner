//
//  LogInScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/19/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import SpriteKit


var userName: String?

//Add the textfield delegate in order to add functionality to the text fields.
class LogInScene: SKScene, UITextFieldDelegate {
    
    var userBkg = SKSpriteNode()
    
//    var userName: String?
    var pwd: String?
    var emailId: String?
    var storageService = App42API.buildStorageService()
    
    
    var gameTitle: UIImageView?
    //Declare variables for text fields
    var playerNameTextField: UITextField?
    var playerPasswordTextField: UITextField?
    var playerEmailTextField: UITextField?
    var doneButton = UIButton(type: UIButtonType.System) as UIButton
    var savedName: NSUserDefaults?
    var savedEmail: NSUserDefaults?
    var savedPassword: NSUserDefaults?
    
    
    //Create node for Audio
    let close = SKAction.playSoundFileNamed("SpaceDoorClose.mp3", waitForCompletion: true)
    
    
    override func didMoveToView(view: SKView) {
        
        //Create for background and add it to the scene
        let userBkgTexture = SKTexture(imageNamed: "OrangeBackground")
        userBkg = SKSpriteNode(texture: userBkgTexture)
        userBkg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        userBkg.zPosition = -1.0
        userBkg.size.height = self.frame.height
        userBkg.size.width = self.frame.width
        self.addChild(userBkg)
        
        
        //Create a image view for the title of the game
        gameTitle = UIImageView(frame: CGRectMake(view.bounds.width / 6.5 , view.bounds.height / 2 - 200, 250, 70))
        view.addSubview(gameTitle!)
        gameTitle!.backgroundColor = UIColor.clearColor()
        gameTitle!.image = UIImage(named: "SpaceRunnerTitle")
        gameTitle?.contentMode = .ScaleAspectFill
        
        
        //Set up the text fields to be displayed for the user to type in their user name, email & password.
        playerNameTextField = UITextField(frame: CGRectMake(view.bounds.width / 2 - 100, gameTitle!.bounds.height + 200, 200, 40))
        view.addSubview(playerNameTextField!)
        playerNameTextField!.placeholder = "Create User Name"
        playerNameTextField!.borderStyle = UITextBorderStyle.RoundedRect
        playerNameTextField!.textColor = UIColor.blackColor()
        playerNameTextField!.backgroundColor = UIColor.whiteColor()
        playerNameTextField!.clearButtonMode = UITextFieldViewMode.WhileEditing
        playerNameTextField!.returnKeyType = .Next
        playerNameTextField!.delegate = self
        
        
        playerEmailTextField = UITextField(frame: CGRectMake(view.bounds.width / 2 - 100, playerNameTextField!.bounds.height + 290, 200, 40))
        view.addSubview(playerEmailTextField!)
        playerEmailTextField!.placeholder = "Enter Email Address"
        playerEmailTextField!.borderStyle = UITextBorderStyle.RoundedRect
        playerEmailTextField!.textColor = UIColor.blackColor()
        playerEmailTextField!.backgroundColor = UIColor.whiteColor()
        playerEmailTextField!.clearButtonMode = UITextFieldViewMode.WhileEditing
        playerEmailTextField!.returnKeyType = .Next
        playerEmailTextField!.delegate = self
        
        playerPasswordTextField = UITextField(frame: CGRectMake(view.bounds.width / 2 - 100, playerEmailTextField!.bounds.height + 350, 200, 40))
        view.addSubview(playerPasswordTextField!)
        playerPasswordTextField!.placeholder = "Create Password"
        playerPasswordTextField!.borderStyle = UITextBorderStyle.RoundedRect
        playerPasswordTextField!.textColor = UIColor.blackColor()
        playerPasswordTextField!.backgroundColor = UIColor.whiteColor()
        playerPasswordTextField!.clearButtonMode = UITextFieldViewMode.WhileEditing
        playerPasswordTextField!.secureTextEntry = true
        playerEmailTextField?.keyboardType = .EmailAddress
        playerPasswordTextField!.returnKeyType = .Done
        playerPasswordTextField!.delegate = self
        
        //Create a UIButton for the user to click when they are done filling the needed information.
        doneButton = UIButton(frame: CGRectMake(view.bounds.width / 2 - 65, playerPasswordTextField!.bounds.height + 420, 120, 40))
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        doneButton.addTarget(self, action: #selector(LogInScene.signIn), forControlEvents: .TouchUpInside)
        view.addSubview(doneButton)
    }
    
    
    
    //Within this method the user can touch the scene to dismiss the keyboard.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        playerNameTextField?.endEditing(true)
        playerEmailTextField?.endEditing(true)
        playerPasswordTextField?.endEditing(true)
        
    }
    
    
    //Method from the delegate that allows the user to go to the next text field when the next button is touched on the keyboard. Dismisses the keyboard when the done button is touched.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == playerNameTextField && playerNameTextField != "" {
            playerEmailTextField?.becomeFirstResponder()
        } else if textField == playerEmailTextField {
            playerPasswordTextField?.becomeFirstResponder()
        } else if textField == playerPasswordTextField {
            playerPasswordTextField?.resignFirstResponder()
        }
        
        return true
    }
    
    
    //Method creates the user for the API cloud.
    func createUser(name: String, userPassword: String, userEmail: String) {
        
        //Create User
        let userService: UserService = App42API.buildUserService() as! UserService
        userService.createUser(name, password: userPassword, emailAddress: userEmail) { (success, response, exception) in
            
            if(success)
            {
                let user = response as! User
                NSLog("%@", user.userName)
                NSLog("%@", user.email)
            }
            else
            {
                NSLog("%@", exception.reason!)
            }
            
        }
        
    }
    
    
    //Method goes to the main game scene when called. Will remove the game title, all text fields and button from the scene when making hte transition.
    func goToMenu() {
        
        gameTitle?.removeFromSuperview()
        playerNameTextField?.removeFromSuperview()
        playerEmailTextField?.removeFromSuperview()
        playerPasswordTextField?.removeFromSuperview()
        doneButton.removeFromSuperview()
        
        let gameScene = GameScene(size: self.size)
        let transition = SKTransition.doorsCloseHorizontalWithDuration(0.8)
        gameScene.scaleMode = SKSceneScaleMode.AspectFill
        runAction(close)
        self.scene?.view?.presentScene(gameScene, transition: transition)
        
    }
    
    //When the done UIButton is touched if any of the text fields are empty alert the user that they can create a user to save the game data or go back to the main menu scene & continue without creating one. If the user fills in all of the information, call the method to create the user passing the username, password and email as parameters. Save it to the device for later use. 
    func signIn(sender: UIButton!) {
        
        if playerNameTextField!.text == "" || playerPasswordTextField!.text == "" || playerEmailTextField!.text == "" {
            
            let alert = UIAlertController(title: "Warning", message: "Create a user to save all game data or go to back to Main Menu.", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Create User", style: .Default, handler: nil)
            let backAction = UIAlertAction(title: "Main Menu", style: .Cancel, handler: { (action) in
                self.goToMenu()
            })
            
            alert.addAction(alertAction)
            alert.addAction(backAction)
            
            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            
        } else {

            userName = (playerNameTextField?.text)!
            pwd = (playerPasswordTextField?.text)!
            emailId = (playerEmailTextField?.text)!

            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "savedName")
            savedPassword?.setObject(pwd, forKey: "savedPasword")
            savedEmail?.setObject(emailId, forKey: "savedEmail")
            
            createUser(userName!, userPassword: pwd!, userEmail: emailId!)
            
            goToMenu()
            
        }
    }
    
    
    
    
}
