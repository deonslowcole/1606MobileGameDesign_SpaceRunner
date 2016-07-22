//
//  LeaderboardScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/20/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import UIKit
import SpriteKit

var playerScore = [String:Double]()

class LeaderboardScene: SKScene {
    
//    var content: FBSDKShareLinkContent = FBSDKShareLinkContent()
    

    
    //Declare a variable for the backbground node
    var leaderBkg = SKSpriteNode()
    
    var boardContainer = SKSpriteNode()
    var gameTitle = SKSpriteNode()
    var leaderLabel = SKLabelNode()
    
    
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
    
    
    var thePlayerName: String?
    var thePlayerScore: Double?
    
//    var playerScore: [String:Double]
    var totalPlayers = [playerScore]
    
    var playerTableView = UITableView()
    
    
    override func didMoveToView(view: SKView) {


//        content.contentURL = NSURL(string: "https://developers.facebook.com")!
        
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
        let segmentControl = UISegmentedControl(items: leaderTabs)
        segmentControl.selectedSegmentIndex = 0
        
        //Declare a constant that will hold the frame/bounds of the screen. Set the position and size of the segment control. Style the segment control with the corner radius, background & tint color. Add it to the view.
        let frame = UIScreen.mainScreen().bounds
        segmentControl.frame = CGRectMake(frame.minX + 10, frame.minY + 50, frame.width - 20, frame.height * 0.05)
        
        segmentControl.layer.cornerRadius = 5.0
        segmentControl.backgroundColor = UIColor.lightTextColor()
        segmentControl.tintColor = UIColor.blueColor()
        
        view.addSubview(segmentControl)
    
        
//        var button: FBSDKShareButton = FBSDKShareButton()
//        button.shareContent = content
//        view.addSubview(button)
        

        //Create a container to hold the menu items when the game loads
        boardContainer = SKSpriteNode(color: UIColor.lightGrayColor(), size: CGSizeMake(self.frame.width * 0.8, self.frame.height * 0.6))
        boardContainer.anchorPoint = CGPointMake(0, 0)
        boardContainer.name = "Menu"
        boardContainer.zPosition = 1.0
        boardContainer.position = CGPointMake(self.size.width/10, self.size.height/4)
        self.addChild(boardContainer)

        p1Name.position = CGPointMake(boardContainer.size.width / 3, boardContainer.size.height - 70)
        p1Name.text = "Player One Name"
        p1Name.fontSize = 50
        p1Name.fontColor = UIColor.blueColor()
        p1Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p1Name)
        
        p1Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), boardContainer.size.height - 70)
        p1Score.text = "100000"
        p1Score.fontSize = 50
        p1Score.fontColor = UIColor.blueColor()
        p1Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p1Score)
        
        p2Name.position = CGPointMake(boardContainer.size.width / 3, p1Name.position.y - 125)
        p2Name.text = "Player Two Name"
        p2Name.fontSize = 50
        p2Name.fontColor = UIColor.blueColor()
        p2Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p2Name)
        
        p2Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p1Score.position.y - 125)
        p2Score.text = "100000"
        p2Score.fontSize = 50
        p2Score.fontColor = UIColor.blueColor()
        p2Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p2Score)
        
        p3Name.position = CGPointMake(boardContainer.size.width / 3, p2Name.position.y - 125)
        p3Name.text = "Player Three Name"
        p3Name.fontSize = 50
        p3Name.fontColor = UIColor.blueColor()
        p3Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p3Name)
        
        p3Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p2Score.position.y - 125)
        p3Score.text = "100000"
        p3Score.fontSize = 50
        p3Score.fontColor = UIColor.blueColor()
        p3Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p3Score)
        
        p4Name.position = CGPointMake(boardContainer.size.width / 3, p3Name.position.y - 125)
        p4Name.text = "Player Four Name"
        p4Name.fontSize = 50
        p4Name.fontColor = UIColor.blueColor()
        p4Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p4Name)
        
        p4Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p3Score.position.y - 125)
        p4Score.text = "100000"
        p4Score.fontSize = 50
        p4Score.fontColor = UIColor.blueColor()
        p4Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p4Score)
        
        p5Name.position = CGPointMake(boardContainer.size.width / 3, p4Name.position.y - 125)
        p5Name.text = "Player Five Name"
        p5Name.fontSize = 50
        p5Name.fontColor = UIColor.blueColor()
        p5Name.fontName = "Chalkboard SE"
        boardContainer.addChild(p5Name)
        
        p5Score.position = CGPointMake(boardContainer.size.width - (boardContainer.size.width / 6), p4Score.position.y - 125)
        p5Score.text = "100000"
        p5Score.fontSize = 50
        p5Score.fontColor = UIColor.blueColor()
        p5Score.fontName = "Chalkboard SE"
        boardContainer.addChild(p5Score)
        
        
        GetTopNRankings()
        
        
    }


    
    //Method from API that gets the top 5 players
    func GetTopNRankings() {
        
        scoreBoardService = App42API.buildScoreBoardService() as? ScoreBoardService
        
        let gameName  = "SpaceRunnerDC"
        let max:Int32 = 5
        scoreBoardService?.getTopNRankings(gameName, max:max, completionBlock: { (success, response, exception) -> Void in
            if(success)
            {
                let game = response as! Game
                NSLog("%@", game.name)
                let scoreList = game.scoreList
                for score in scoreList {
                    self.thePlayerName = score.userName
                    print(self.thePlayerName!)
                    let scoreValue = score.value as Double
                    self.thePlayerScore = scoreValue
                    print(self.thePlayerScore!)
                    print("%@", score.scoreId)
                    playerScore.updateValue(self.thePlayerScore!, forKey: self.thePlayerName!)
                }
            } else {
                NSLog("%@", exception.reason!)
                NSLog("%d", exception.appErrorCode)
                NSLog("%d", exception.httpErrorCode)
                NSLog("%@", exception.userInfo!)
            }
        })
        totalPlayers.append(playerScore)
        print(totalPlayers)
        
    }

    
    

}
