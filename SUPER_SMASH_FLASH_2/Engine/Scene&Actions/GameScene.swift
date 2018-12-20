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
    var InputDetected = false
    var alreadyidling = false
    var jump = true
    
    var Direction = "NONE"
    
    func SpawnNewChar(characterNumber: Int) {
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7.5, y: 7))
        player.physicsBody!.isDynamic = true
        player.physicsBody!.affectedByGravity = true
        player.physicsBody!.friction = 1
        player.physicsBody!.restitution = 0
        player.position = CGPoint(x: 370, y:136.174)
        player.physicsBody!.mass = 0.1
        player.physicsBody!.allowsRotation = false
      
        player.Idle("RIGHT")
        Direction = "RIGHT"
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
        player.physicsBody?.mass = 1
        lastlocation = player.position
        
        
    }
    
    func figureOutThisFuckery(_ node: SKNode , character: Int) {
        alreadyidling = false
            switch node {
            case DP_E: Direction = "RIGHT"
                player.Strafe(Direction)
            case DP_W: Direction = "LEFT"
                player.Strafe(Direction)
            case DP_N:
                player.Jump(Direction)
                InputDetected = false
                jump = true
            case DP_S:
                player.Duck(Direction)
            case DP_NE: Direction = "RIGHT"
                player.Jump(Direction)
                jump = true
            case DP_NW: Direction = "LEFT"
                player.Jump(Direction)
                jump = true
            case DP_SE: Direction = "RIGHT"
                player.Duck(Direction)
            case DP_SW: Direction = "LEFT"
               player.Duck(Direction)
            case NES_A:
                InputDetected = false
                player.Attack(Direction)
            case NES_B:
                InputDetected = false
                
            default: InputDetected = false
                
               
            }
        
        colorService.send(colorName: "\(player.position)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        InputDetected = true
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
            figureOutThisFuckery(node, character: 1)}
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       // InputDetected = true
       // let touchlocation = touches.first?.location(in: self)
       // if let node = self.nodes(at: touchlocation!).first {
       //     figureOutThisFuckery(node, character: 1)}
        }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if player.action(forKey: "ATTACK") == nil {
            player.Idle(Direction)
            print("CAWCAW CAWCAW")
        }
        InputDetected = false
    }
    
    func ThatBoiFallin() -> Bool {
        if lastlocation.y > player.position.y {
            return true
        } else {
            return false
        }
    }
    
    func OhMyLordHeDead() {
        if lastlocation == player.position && alreadyidling == false {
            player.Idle(Direction)
            alreadyidling = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        player.physicsBody?.allowsRotation = false
        if InputDetected {
        
        switch Direction {
        case "RIGHT":
            player.run(SKAction.move(by: CGVector(dx: 3, dy: 0), duration: 0.1))
            
        case "LEFT":
            player.run(SKAction.move(by: CGVector(dx: -3, dy: 0), duration: 0.1))
            
        default: break
            }
            
        }
        
        if jump == true {
            if lastlocation.x == player.position.x {
         
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 400))
            }
            jump = false
        }
        
        if player.position.y < lastlocation.y {
            player.Fall(Direction)
        }
        if player.position.x == lastlocation.x {
            if player.action(forKey: "FALL") == nil {
                player.Idle(Direction)
            }
        }
        
        
        lastlocation = player.position
    }
    


}






