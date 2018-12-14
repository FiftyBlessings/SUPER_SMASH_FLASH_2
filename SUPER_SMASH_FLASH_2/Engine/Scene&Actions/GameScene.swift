import SpriteKit
import Foundation
import AVKit

class GameScene: SKScene , SKPhysicsContactDelegate {

    

var platform = SKSpriteNode()
var player = SKSpriteNode()
let colorService = ColorService()
    
    var DP_N = SKSpriteNode()
    var DP_NE = SKSpriteNode()
    var DP_NW = SKSpriteNode()
    var DP_E = SKSpriteNode()
    var DP_SE = SKSpriteNode()
    var DP_S = SKSpriteNode()
    var DP_SW = SKSpriteNode()
    var  DP_W = SKSpriteNode()
    var Direction = "NONE"

    override func didMove(to view: SKView) {
      
        
        
        

        
        backgroundColor = .white
        colorService.delegate = self
        physicsWorld.contactDelegate = self
        
         DP_N = self.childNode(withName: "DPAD_N") as! SKSpriteNode
         DP_NE = self.childNode(withName: "DPAD_NE") as! SKSpriteNode
         DP_NW = self.childNode(withName: "DPAD_NW") as! SKSpriteNode
         DP_E = self.childNode(withName: "DPAD_E") as! SKSpriteNode
         DP_SE = self.childNode(withName: "DPAD_SE") as! SKSpriteNode
         DP_S = self.childNode(withName: "DPAD_S") as! SKSpriteNode
         DP_SW = self.childNode(withName: "DPAD_SW") as! SKSpriteNode
         DP_W = self.childNode(withName: "DPAD_W") as! SKSpriteNode
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.8)
        
 
    
        
        
        
    
        addChild(player)
     
        player.physicsBody?.affectedByGravity = true
  
        player.position = CGPoint(x: 370, y:136.174)
        player.physicsBody?.friction = 1000
        player.physicsBody?.restitution = 0
        platform.physicsBody?.restitution = 0
        

        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7.5, y: 7))
        
        
      
    }
    func buildplayer(Atlas: String) {
        let playerAnimatedAtlas = SKTextureAtlas(named: Atlas)
        var walkFrames: [SKTexture] = []
        
        let numImages = playerAnimatedAtlas.textureNames.count
          for i in 1...numImages {
            let playerTextureName = "\(Atlas)\(i)"
            walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
        }
        playerWalkingFrames = walkFrames
        let firstFrameTexture = playerWalkingFrames[0]
        player = SKSpriteNode(texture: firstFrameTexture)
        
        
       
    }
    func animateplayer() {
        player.run(SKAction.repeatForever(
            SKAction.animate(with: playerWalkingFrames,
                             timePerFrame: 0.1,
                             resize: true,
                             restore: true)),
                 withKey:"walkingInPlaceplayer")
    }
var touch = false
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
            touch = true
            
            switch node {
            case DP_E:
                Direction = "RIGHT"
                player.StrafeRight()
            case DP_W:
                Direction = "LEFT"
                player.StrafeLeft()
            case DP_N:
                Direction = "UP"
                player.Jump()
            case DP_S:
                Direction = "DOWN"
                player.Duck()
            default:
                print("yeet")
            }
    colorService.send(colorName: Direction)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
   
}
    
        
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if Direction == "LEFT" {
            player.IdleLeft()
        } else if Direction == "RIGHT" {
            player.IdleRight()
        }
        Direction = "NONE"
        colorService.send(colorName: Direction)
    }
    var lastposition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func update(_ currentTime: TimeInterval) {
        switch Direction {
        case "RIGHT":
            player.run(SKAction.move(by: CGVector(dx: 3, dy: 0), duration: 0.1))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
        case "LEFT":
            player.run(SKAction.move(by: CGVector(dx: -3, dy: 0), duration: 0.1))
            player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: -7, y: 7))
       
            
        default: break
         
        }
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 50), center: CGPoint(x: 7, y: 7))
    }
    
}








