//
//  DexScene.swift
//  EggieRun
//
//  Created by CNA_Bld on 3/20/16.
//  Copyright © 2016 Eggieee. All rights reserved.
//

import SpriteKit

class DexScene: SKScene {
    
    private static let TITLE_TEXT = "Éggdex"
    private static let TITLE_FONT = "Chalkduster"
    private static let TITLE_SIZE = CGFloat(40)
    private static let TITLE_TOP_PADDING = CGFloat(20)
    
    private static let BACK_BUTTON_SIZE = CGFloat(80)
    private static let FLIP_BUTTON_WIDTH = CGFloat(90)
    private static let FLIP_BUTTON_HEIGHT = CGFloat(60)
    private static let FLIP_BUTTON_X = CGFloat(500)
    private static let FLIP_BUTTON_Y = CGFloat(80)
    
    private static let DISH_FIRST_PAGE = Array(DishDataController.singleton.dishes[0..<12])
    private static let DISH_SECOND_PAGE = Array(DishDataController.singleton.dishes[12..<21])
    
    static let TOP_BAR_HEIGHT = CGFloat(80)
    static let GRID_WIDTH_RATIO = CGFloat(4.0 / 7)
    static let DETAIL_WIDTH_RATIO = CGFloat(3.0 / 7)
    
    static let UNACTIVATED_FILTER = CIFilter(name: "CIColorControls", withInputParameters: ["inputBrightness": -1])
    
    private var buttonBack: SKSpriteNode!
    private var gridNode: DexGridNode!
    private var detailNode: DexDetailNode!
    private var flipPageNode: SKSpriteNode!

    
    override func didMoveToView(view: SKView) {
        BGMPlayer.singleton.moveToStatus(.Dex)
        
        let titleLabel = SKLabelNode(fontNamed: DexScene.TITLE_FONT)
        titleLabel.text = DexScene.TITLE_TEXT
        titleLabel.fontSize = DexScene.TITLE_SIZE
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.frame.height - DexScene.TITLE_SIZE - DexScene.TITLE_TOP_PADDING)
        self.addChild(titleLabel)
        
        buttonBack = SKSpriteNode(imageNamed: "button-return")
        buttonBack.size = CGSize(width: DexScene.BACK_BUTTON_SIZE, height: DexScene.BACK_BUTTON_SIZE)
        buttonBack.position = CGPoint(x: DexScene.BACK_BUTTON_SIZE, y: self.frame.height - DexScene.BACK_BUTTON_SIZE / 2)
        self.addChild(buttonBack)
        
        gridNode = DexGridNode(sceneHeight: self.frame.height, sceneWidth: self.frame.width, dishList: DexScene.DISH_FIRST_PAGE, pageNumber: 1)
        self.addChild(gridNode)
        
        createDetailNode()
        
        flipPageNode = SKSpriteNode(imageNamed: "arrow-right")
        flipPageNode.position = CGPoint(x: DexScene.FLIP_BUTTON_X, y: DexScene.FLIP_BUTTON_Y)
        flipPageNode.zPosition = 2
        flipPageNode.size = CGSize(width: DexScene.FLIP_BUTTON_WIDTH, height: DexScene.FLIP_BUTTON_HEIGHT)
        addChild(flipPageNode)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let touchLocation = touch.locationInNode(self)
        
        // back
        if buttonBack.containsPoint(touchLocation) {
            let menuScene = MenuScene.singleton
            self.view?.presentScene(menuScene!, transition: MenuScene.BACK_TRANSITION)
        }
        
        // flipping page
        if flipPageNode.containsPoint(touchLocation) {
            if gridNode.pageNumber == 1 {
                gridNode.removeFromParent()
                gridNode = DexGridNode(sceneHeight: self.frame.height, sceneWidth: self.frame.width, dishList: DexScene.DISH_SECOND_PAGE, pageNumber:2)
                self.addChild(gridNode)
                flipPageNode.texture = SKTexture(imageNamed: "arrow-left")
            } else {
                gridNode.removeFromParent()
                gridNode = DexGridNode(sceneHeight: self.frame.height, sceneWidth: self.frame.width, dishList: DexScene.DISH_FIRST_PAGE, pageNumber:1)
                self.addChild(gridNode)
                flipPageNode.texture = SKTexture(imageNamed: "arrow-right")
            }
        }
        
        // dishes
        let touchLocationInGrid = touch.locationInNode(gridNode)
        for dishNode in gridNode.dishNodes {
            if dishNode.containsPoint(touchLocationInGrid) {
                gridNode.moveEmitter(dishNode)
                detailNode.setDish(dishNode.dish, activated: dishNode.activated)
                break
            }
        }
    }
    
    func createDetailNode() {
        detailNode = DexDetailNode(sceneHeight: self.frame.height, sceneWidth: self.frame.width)
        self.addChild(detailNode)
    }
    
    override func willMoveFromView(view: SKView) {
        gridNode.removeEmitter()
        DishDataController.singleton.clearNewFlags()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
