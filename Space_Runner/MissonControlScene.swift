//
//  MissonControlScene.swift
//  Space_Runner
//
//  Created by Deon Cole on 7/8/16.
//  Copyright © 2016 Deon Cole. All rights reserved.
//

import SpriteKit

class MissonControlScene: SKScene {
    
    var mcBkg = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        let mcBkgTexture = SKTexture(imageNamed: "OrangeBackground")
        mcBkg = SKSpriteNode(texture: mcBkgTexture)
        mcBkg.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        mcBkg.size.height = self.frame.height
        mcBkg.size.width = self.frame.width
        self.addChild(mcBkg)
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    

}
