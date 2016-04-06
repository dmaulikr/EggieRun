//
//  MenuScene.swift
//  EggieRun
//
//  Created by CNA_Bld on 3/18/16.
//  Copyright © 2016 Eggieee. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    static let singleton = MenuScene(fileNamed: "MenuScene")
    
    private var buttonPlay: SKSpriteNode!
    private var buttonDex: SKSpriteNode!
    
    private var initialized = false
    
    override func didMoveToView(view: SKView) {
        if initialized {
            return
        }
        initialized = true
        
        changeBackground("menu-background")
        
        buttonPlay = SKSpriteNode(imageNamed: "start-button")
        buttonPlay.position = CGPoint(x: 215, y: 420)
        self.addChild(buttonPlay)
        
        buttonDex = SKSpriteNode(imageNamed: "eggdex-button")
        buttonDex.position = CGPoint(x: 210, y: 270)
        self.addChild(buttonDex)
        
        //对不起我先静音了
        //self.runAction(SKAction.playSoundFileNamed("road-runner", waitForCompletion: true))
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        
        if buttonPlay.containsPoint(touchLocation) {
            let gameScene = GameScene(fileNamed: "GameScene")!
            let transition = SKTransition.doorsOpenVerticalWithDuration(0.5)
            self.view?.presentScene(gameScene, transition: transition)
        } else if buttonDex.containsPoint(touchLocation) {
            let dexScene = DexScene(size: self.size)
            let transition = SKTransition.doorsOpenVerticalWithDuration(0.5)
            self.view?.presentScene(dexScene, transition: transition)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
