//
//  LeaderboardScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/20/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import SpriteKit
import Social


class LeaderboardScene: SKScene, CLLocationManagerDelegate {
    
    var segmentControl = UISegmentedControl()
    
    let geoService = App42API.buildGeoService() as? GeoService
    
    //Declare variables and constant that is used for location manager framework
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var geoCoder = CLGeocoder()
    var lat = Double()
    var long = Double()
    var city = String()
    
    //Declare a variable for the backbground node
    var leaderBkg = SKSpriteNode()
    var boardContainer = SKSpriteNode()
    
    //Declare variables to hold the labels for the player names and scores
    var p1Name = SKLabelNode()
    var p1Score = SKLabelNode()
    var p2Name = SKLabelNode()
    var p2Score = SKLabelNode()
    var p3Name = SKLabelNode()
    var p3Score = SKLabelNode()
    var p4Name = SKLabelNode()
    var p4Score = SKLabelNode()
    var p5Name = SKLabelNode()
    var p5Score = SKLabelNode()
    
    var shareButton = SKSpriteNode()
    var menu = SKSpriteNode()
    
    //Create node for Audio
    let close = SKAction.playSoundFileNamed("SpaceDoorClose.mp3", waitForCompletion: true)
    
    
    override func didMoveToView(view: SKView) {

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Create for background and add it to the scene
        let leadBkgTexture = SKTexture(imageNamed: "OrangeBackground")
        leaderBkg = SKSpriteNode(texture: leadBkgTexture)
        leaderBkg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        leaderBkg.zPosition = -1.0
        leaderBkg.size.height = self.frame.height
        leaderBkg.size.width = self.frame.width
        self.addChild(leaderBkg)
        
        
        //Declare a constant for the array of items that will be displayed in the segment control. Declare a constant to initalize the segment control with the created array of items. Have the selected index of the segment control start at 0.
        let leaderTabs = ["Top Players", "Top Regional Players"]
        segmentControl = UISegmentedControl(items: leaderTabs)
        segmentControl.selectedSegmentIndex = 0
        
        //Declare a constant that will hold the frame/bounds of the screen. Set the position and size of the segment control. Style the segment control with the corner radius, background & tint color. Add it to the view.
        let frame = UIScreen.mainScreen().bounds
        segmentControl.frame = CGRectMake(frame.minX + 10, frame.minY + 50, frame.width - 20, frame.height * 0.05)
        
        segmentControl.layer.cornerRadius = 5.0
        segmentControl.backgroundColor = UIColor.lightTextColor()
        segmentControl.tintColor = UIColor.blueColor()
        
        view.addSubview(segmentControl)

        

        //Create a container to hold the menu items when the game loads
        boardContainer = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.frame.width * 0.8, self.frame.height * 0.6))
        boardContainer.anchorPoint = CGPointMake(0, 0)
        boardContainer.name = "Menu"
        boardContainer.zPosition = 1.0
        boardContainer.position = CGPointMake(self.size.width/10, self.size.height/4)
        self.addChild(boardContainer)

        p1Name.position = CGPointMake(boardContainer.size.width / 3, boardContainer.size.height - 70)
        p1Name.text = ""
        p1Name.fontSize = 50
        p1Name.fontColor = UIColor.blueColor()
        p1Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p1Name)
        
        p1Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), boardContainer.size.height - 70)
        p1Score.text = ""
        p1Score.fontSize = 50
        p1Score.fontColor = UIColor.blueColor()
        p1Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p1Score)
        
        p2Name.position = CGPointMake(boardContainer.size.width / 3, p1Name.position.y - 125)
        p2Name.text = ""
        p2Name.fontSize = 50
        p2Name.fontColor = UIColor.blueColor()
        p2Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p2Name)
        
        p2Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p1Score.position.y - 125)
        p2Score.text = ""
        p2Score.fontSize = 50
        p2Score.fontColor = UIColor.blueColor()
        p2Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p2Score)
        
        p3Name.position = CGPointMake(boardContainer.size.width / 3, p2Name.position.y - 125)
        p3Name.text = ""
        p3Name.fontSize = 50
        p3Name.fontColor = UIColor.blueColor()
        p3Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p3Name)
        
        p3Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p2Score.position.y - 125)
        p3Score.text = ""
        p3Score.fontSize = 50
        p3Score.fontColor = UIColor.blueColor()
        p3Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p3Score)
        
        p4Name.position = CGPointMake(boardContainer.size.width / 3, p3Name.position.y - 125)
        p4Name.text = ""
        p4Name.fontSize = 50
        p4Name.fontColor = UIColor.blueColor()
        p4Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p4Name)
        
        p4Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p3Score.position.y - 125)
        p4Score.text = ""
        p4Score.fontSize = 50
        p4Score.fontColor = UIColor.blueColor()
        p4Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p4Score)
        
        p5Name.position = CGPointMake(boardContainer.size.width / 3, p4Name.position.y - 125)
        p5Name.text = ""
        p5Name.fontSize = 50
        p5Name.fontColor = UIColor.blueColor()
        p5Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p5Name)
        
        p5Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p4Score.position.y - 125)
        p5Score.text = ""
        p5Score.fontSize = 50
        p5Score.fontColor = UIColor.blueColor()
        p5Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p5Score)
        
        
        segmentControl.addTarget(self, action: #selector(LeaderboardScene.switchPlayers), forControlEvents: UIControlEvents.AllEvents)
        
        shareButton = SKSpriteNode(texture: spriteSheet.shareButton())
        shareButton.name = "Share"
        shareButton.position = CGPointMake(self.frame.width / 2, self.frame.height / 6)
        shareButton.size = CGSizeMake(self.frame.width / 7, self.frame.height / 10)
        self.addChild(shareButton)
        
        //Create texture & node for the menu to allow users to go back
        let menuTexture = SKTexture(imageNamed: "MenuButton2.png")
        menu = SKSpriteNode(texture: menuTexture)
        menu.name = "Menu"
        menu.position = CGPointMake(self.size.width / 2, 100)
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
             
                if name == "Share" {
                    share()
                } else if name == "Menu" {
                    let gameScene = GameScene(size: self.size)
                    let transition = SKTransition.doorsCloseHorizontalWithDuration(0.8)
                    gameScene.scaleMode = SKSceneScaleMode.AspectFill
                    runAction(close)
                    segmentControl.removeFromSuperview()
                    self.scene?.view?.presentScene(gameScene, transition: transition)
                    
                }
            }
        }
    }

    
    

    func switchPlayers(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            GetTopNRankings()
        case 1:
            createGeoPoints()
            print("Top Regional")
        default:
            print("This is the defualt")
            
        }
        
    }

    //Use the location manager delegate to get the location. Reverse geo code the location passing the users location as a parameter. In the completion handler get the array of the placemarks, set a constant equal to placemarks array and set the city equal to the locality of the placemarks. Use the city in the geoPoint method to set the point location in the API.
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last!
        
        locationManager.stopUpdatingLocation()
        
        geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if let error = error {
                print(error)
            } else {
                let placeMark = (placemarks?.last)!
                self.city = placeMark.locality!
                print(self.city)
            }
        }
    }
    
    
    //MARK: Social Sharing
    
    func share() {
        
        //Create the alert controller
        let socialView = UIAlertController(title: "", message: "Share to Facebook", preferredStyle: .ActionSheet)
        
        //Declare a constant equal to the main screen of the device
        let view = UIScreen.mainScreen()
        
        //Use optional chainging to check for the devices window. Create a image context that is the view of the users screen and set it to a constant that can be displayed when the users touches the share button.
        if let deviceScreen = UIApplication.sharedApplication().keyWindow {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
            deviceScreen.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
            
            let pic = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //Create Social Media actions. Within the social media buttons check to see if the user is logged in. If not alert them that they need to be signed in so that they can share.
            let facebookButton = UIAlertAction(title: "Share on Facebook", style: .Default) { (action) in
                
                if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
                    
                    let facebookView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                    
                    //Set the text & image of the post
                    facebookView.setInitialText("Check out my scores in Space Runner.")
                    facebookView.addImage(pic)
                    
                    //Present the facebook view
                    self.view?.window?.rootViewController?.presentViewController(facebookView, animated: true, completion: nil)
                    
                } else {
                    
                    self.alertMessage("You are not signed in. Go to settings and sign in to your Facebook account.")
                }
                
            }
            
            //Add the button to the alert view
            socialView.addAction(facebookButton)
            
            //Present the social alert view
            self.view?.window?.rootViewController!.presentViewController(socialView, animated: true, completion: nil)
        }
    }
    
    
    //This method alerts the user that they aren't signed into any social media for posting
    func alertMessage(message: String) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .Alert)
        
        let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okButton)
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    

    //MARK: API Functions
    
    //Method from API that gets the top 5 players
    func GetTopNRankings() {
        
        scoreBoardService = App42API.buildScoreBoardService() as? ScoreBoardService
        
        let playerLabel = [p1Name, p2Name, p3Name, p4Name, p5Name]
        let playerScore = [p1Score, p2Score, p3Score, p4Score, p5Score]
        
        
        let gameName  = "SpaceRunnerDC"
        let max:Int32 = 5
        scoreBoardService?.getTopNRankings(gameName, max:max, completionBlock: { (success, response, exception) -> Void in
            if(success)
            {
                let game = response as! Game
                NSLog("%@", game.name)
                let scoreList = game.scoreList
                for score in scoreList.enumerate(){
                    playerLabel[score.index].text = score.element.userName
                    print(score.element.userName)
                    let scoreValue = score.element.value as Double
                    playerScore[score.index].text = "\(scoreValue)"
                    print("%@", score.element.scoreId)
                }
            } else {
                NSLog("%@", exception.reason!)
                NSLog("%d", exception.appErrorCode)
                NSLog("%d", exception.httpErrorCode)
                NSLog("%@", exception.userInfo!)
            }
        })
    }


    //Metho from API that gets the location of the players device
    func createGeoPoints() {
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways {
            
            currentLocation = locationManager.location!
            
        }
        
        let geostorageName = "SpaceRunnerGeo";
        let geoPointsList:NSMutableArray=NSMutableArray()
        let gp:GeoPoint = GeoPoint()
        gp.marker = city
        gp.latitude = currentLocation.coordinate.latitude
        gp.longitude = currentLocation.coordinate.longitude
        geoPointsList.addObject(gp)
        //App42API.initializeWithAPIKey("API-KEY", andSecretKey: "SECRET_KEY")
        //let geoService = App42API.buildGeoService as! GeoService
        geoService?.createGeoPoints(geostorageName, geoPointsList: geoPointsList as [AnyObject],completionBlock:{ (success, response, exception) -> Void in
            
            if (success)
            {
                let geo = response as! Geo
                NSLog("storageName is %@", geo.storageName);
                for point in geo.pointList
                {
                    NSLog("latitude is %f", point.lat);
                    NSLog("longitude is %f", point.lng);
                    NSLog("marker is %@", point.marker);
                }
            }
            else
            {
                NSLog("%@", exception.reason!)
                NSLog("%d", exception.appErrorCode)
                NSLog("%d", exception.httpErrorCode)
                NSLog("%@", exception.userInfo!)
            }
        })
        
        getPointsWithInCircle()
    }
    
    
    //Method from teh API that gets all of the geo points in the radius o fone kilometer
    func getPointsWithInCircle() {
        let storageName = "SpaceRunnerGeo"
        let lat = currentLocation.coordinate.latitude
        let lng = currentLocation.coordinate.longitude
        let radiusInKM = 1.00
        let resultLimit:Int32 = 2
        // App42API.initializeWithAPIKey("API-KEY", andSecretKey: "SECRET_KEY")
        // let geoService = App42API.buildGeoService as! GeoService
        geoService?.getPointsWithInCircle(storageName,latitude:lat,longitude:lng,radiusInKM:radiusInKM,resultLimit:resultLimit, completionBlock:{ (success, response, exception) -> Void in
            if (success)
            {
                let geo = response as! Geo
                NSLog("storageName is %@", geo.storageName);
                for point in geo.pointList {
                    
                    if self.city == point.marker {
                        self.GetTopNRankings()
                    }
//                    NSLog("latitude is %f", point.lat)
//                    NSLog("longitude is %f", point.lng)
//                    NSLog("marker is %@", point.marker)
                }
            }
            else
            {
                NSLog("%@", exception.reason!)
                NSLog("%d", exception.appErrorCode)
                NSLog("%d", exception.httpErrorCode)
                NSLog("%@", exception.userInfo!)
            }
        })
    }
    
   

}
