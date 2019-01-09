//
//  MapScene.swift
//  SUPER_SMASH_FLASH_2
//
//  Created by Jonathan Tielen on 2018-12-19.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import GameplayKit

class MapScene: SKScene {
    
    static var MapSelected = 0
    var FDLevel = SKSpriteNode()
    var TempleLevel = SKSpriteNode()
    var PeachLevel = SKSpriteNode()
    var goBack = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        FDLevel = self.childNode(withName: "FDLevel") as! SKSpriteNode
        TempleLevel = self.childNode(withName: "TempleLevel") as! SKSpriteNode
        PeachLevel = self.childNode(withName: "PeachLevel") as! SKSpriteNode
        goBack = self.childNode(withName: "goBack") as! SKSpriteNode
        
        
        goBack.color = .clear
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchLocation!).first {
            if node == FDLevel  {
                if let nextScene = GameScene(fileNamed: "GameScene"){
                    MapScene.MapSelected = 1
                    nextScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
                
            } else if node == TempleLevel {
                if let nextScene = GameScene(fileNamed: "GameScene"){
                    MapScene.MapSelected = 2
                    nextScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
            } else if node == PeachLevel {
                if let nextScene = GameScene(fileNamed: "GameScene"){
                    MapScene.MapSelected = 3
                    nextScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
            } else if node == goBack {
                if let nextScene = SelectionScene(fileNamed: "SelectionScene"){
                    nextScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
            }
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

