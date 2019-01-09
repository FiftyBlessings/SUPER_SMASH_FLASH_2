//
//  MainMenu.swift
//  SUPER_SMASH_FLASH_2
//
//  Created by Jonathan Tielen on 2018-12-19.
//  Copyright © 2018 Period Three. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    
    var button1 = SKSpriteNode()
    var button2 = SKSpriteNode()
    
    
    
    
    
    override func didMove(to view: SKView) {
        button1 = self.childNode(withName: "smashButton") as! SKSpriteNode
        button2 = self.childNode(withName: "creditsButton") as! SKSpriteNode
        
        button1.color = .clear
        button2.color = .clear
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self)
        print("yeet")
        if let node = self.nodes(at: touchLocation!).first {
            if node == button1{
                if let nextScene = SelectionScene(fileNamed: "SelectionScene"){
                    nextScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
                
            } else if node == button2 {
            }
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
