//
//  SelectionScene.swift
//  SUPER_SMASH_FLASH_2
//
//  Created by Jonathan Tielen on 2018-12-19.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import GameplayKit

class SelectionScene: SKScene {
    
    
    var playButton = SKSpriteNode()
    var backButton = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "playButton") as! SKSpriteNode
        backButton = self.childNode(withName: "backButton") as! SKSpriteNode
        
        playButton.color = .clear
        backButton.color = .clear
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchLocation!).first {
            if node == playButton {
                if let nextScene = MapScene(fileNamed: "MapScene"){
                    nextScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
                
            } else if node == backButton {
                if let nextScene = MainMenu(fileNamed: "MainMenu"){
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
