import SpriteKit
import Foundation
import AVKit

class GameScene: SKScene , SKPhysicsContactDelegate {

    let colorService = ColorService()
    var player = SKSpriteNode()
    var DP_SW = SKSpriteNode(); var  DP_W = SKSpriteNode();
    var DP_NW = SKSpriteNode(); var DP_E = SKSpriteNode();
    var NES_B = SKSpriteNode(); var NES_A = SKSpriteNode();
    var DP_N = SKSpriteNode(); var DP_NE = SKSpriteNode();
    var DP_SE = SKSpriteNode(); var DP_S = SKSpriteNode();
    
    var Direction = "NONE"
    
    func SpawnNewChar(characterNumber: Int) {
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7.5, y: 7))
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.friction = 1000
        player.physicsBody?.restitution = 0
        player.position = CGPoint(x: 370, y:136.174)
        player.IdleRight()
        addChild(player)
    }
    
    var lastlocation = CGPoint(x: 0, y: 0)
    override func didMove(to view: SKView) {
        NES_A = self.childNode(withName: "BUTTON_A") as! SKSpriteNode; NES_B = self.childNode(withName: "BUTTON_B") as! SKSpriteNode
        DP_NW = self.childNode(withName: "DPAD_NW") as! SKSpriteNode; DP_SE = self.childNode(withName: "DPAD_SE") as! SKSpriteNode
        DP_W = self.childNode(withName: "DPAD_W") as! SKSpriteNode; DP_NE = self.childNode(withName: "DPAD_NE") as! SKSpriteNode
        DP_S = self.childNode(withName: "DPAD_S") as! SKSpriteNode; DP_SW = self.childNode(withName: "DPAD_SW") as! SKSpriteNode
        DP_E = self.childNode(withName: "DPAD_E") as! SKSpriteNode; DP_N = self.childNode(withName: "DPAD_N") as! SKSpriteNode
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.8)
        physicsWorld.contactDelegate = self
        colorService.delegate = self
        
        SpawnNewChar(characterNumber: 1)
        lastlocation = player.position
        
        
    }
    
    func figureOutThisFuckery(_ node: SKNode , character: Int) {
        
            switch node {
            case DP_E: Direction = "RIGHT"
                player.StrafeRight()
            case DP_W: Direction = "LEFT"
                player.StrafeLeft()
            case DP_N: Direction = "UP"
                player.Jump()
            case DP_S: Direction = "DOWN"
                player.Duck()
            case DP_NE: Direction = "UPRIGHT"
                player.Jump()
            case DP_NW: Direction = "UPLEFT"
                player.Jump()
            case DP_SE: Direction = "DOWNRIGHT"
                player.Duck()
            case DP_SW: Direction = "DOWNLEFT"
               player.Duck()
            default: print("yeet")
            }
            if node == NES_A && Direction == "LEFT"{
                player.AttackLeft()
    } else if node == NES_A && Direction == "RIGHT" {
                player.AttackRight()
            }
            colorService.send(colorName: Direction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
            figureOutThisFuckery(node, character: 1)}
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
            figureOutThisFuckery(node, character: 1)}
        }
    
    func ThatBoiFallin() -> Bool {
        if lastlocation.x > player.position.x {
            return true
        } else {
            return false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch Direction {
        case "RIGHT":
            player.run(SKAction.move(by: CGVector(dx: 3, dy: 0), duration: 0.1))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
        case "LEFT":
            player.run(SKAction.move(by: CGVector(dx: -3, dy: 0), duration: 0.1))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: -7, y: 7))
        case "UP":
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
        case "UPRIGHT":
            player.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
        case "UPLEFT":
            player.physicsBody?.applyForce(CGVector(dx: -100, dy: 100))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
        default: break
        }
        if ThatBoiFallin() {
            player.
        }
        
    }
    


}






