

import Foundation
import SpriteKit

class LOBBIES: SKScene {
    override func didMove(to view: SKView) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let button1 = self.childNode(withName: "HOST") as! SKSpriteNode
        let button2 = self.childNode(withName: "JOIN") as! SKSpriteNode
        
        let touchLocation = touches.first?.location(in: self)
        print("yeet")
        if let node = self.nodes(at: touchLocation!).first {
            if node == button1{
                if let nextScene = HOST(fileNamed: "HOST"){
                    nextScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }
            } else if node == button2 {
                if let nextScene = HOST(fileNamed: "JOIN"){
                    nextScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fade(withDuration: 1)
                    view?.presentScene(nextScene, transition: transition)
                }}
        }
    }
    
    
}
