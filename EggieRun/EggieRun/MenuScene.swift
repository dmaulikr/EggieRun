//
//  MenuScene.swift
//  EggieRun
//
//  Created by CNA_Bld on 3/18/16.
//  Copyright © 2016 Eggieee. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    private var buttonPlay: SKSpriteNode!
    private var buttonDex: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Eggie Run"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        
        let label_kakkokari = SKLabelNode(fontNamed:"Chalkduster")
        label_kakkokari.text = "(name subject to change)"
        label_kakkokari.fontSize = 12
        label_kakkokari.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-45)
        self.addChild(label_kakkokari)
        
        let label_temp = SKLabelNode(fontNamed:"Courier")
        label_temp.text = "left btn -> play, right btn -> éggdex"
        label_temp.fontSize = 12
        label_temp.position = CGPoint(x:CGRectGetMidX(self.frame), y:20)
        self.addChild(label_temp)
        
        buttonPlay = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 160, height: 80))
        buttonPlay.position = CGPoint(x: CGRectGetMidX(self.frame) - 120, y: 260)
        self.addChild(buttonPlay)
        
        buttonDex = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 160, height: 80))
        buttonDex.position = CGPoint(x: CGRectGetMidX(self.frame) + 120, y: 260)
        self.addChild(buttonDex)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        
        if buttonPlay.containsPoint(touchLocation) {
            let gameScene = GameScene(fileNamed: "GameScene")!
            let transition = SKTransition.doorsOpenVerticalWithDuration(0.5)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
