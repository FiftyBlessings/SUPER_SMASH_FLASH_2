import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    let playerCategory: UInt32 = 0x1 << 0
    let platformCategory: UInt32 = 0x1 << 1
    
var player = SKSpriteNode()
var platform = SKSpriteNode()
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
    
private var playerWalkingFrames: [SKTexture] = []
    
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

        
        platform.color = .black
        buildplayer(Atlas: "R_LLOYD_IDLE")
        animateplayer()
 
        platform.position = CGPoint(x: 368, y: -40.5)
        platform.size = CGSize(width: 736, height: 100)
        platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1500, height: 40))
        platform.physicsBody?.restitution = 1.1
        platform.physicsBody?.affectedByGravity = false
        platform.physicsBody?.allowsRotation = false
        platform.physicsBody?.pinned = true
        
        
        addChild(platform)
    
        addChild(player)
       player.physicsBody = SKPhysicsBody(circleOfRadius: (player.size.width)/2)
        player.physicsBody?.affectedByGravity = true
  
        player.position = CGPoint(x: 500, y:200)
        player.physicsBody?.friction = 1000
        player.physicsBody?.restitution = 0
        platform.physicsBody?.restitution = 0
        
      
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
                             resize: false,
                             restore: true)),
                 withKey:"walkingInPlaceplayer")
    }
var touch = false
    
    func moveto(_ dircection: CGPoint) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
            if node == DP_E{
                touch = true
                Direction = "RIGHT"
                player.StrafeRight()
            } else if node == DP_W {
                touch = true
                Direction = "LEFT"
                player.StrafeLeft()
            } else if node == DP_N {
                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
            } else if node == DP_NE {
                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                touch = true
                Direction = "RIGHT"
            } else if node == DP_NW {
                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 45))
                touch = true
                Direction = "LEFT"
            }
    
        }
        
        for _ in touches {}
        touch = true
        colorService.send(colorName: "true")
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
        colorService.send(colorName: "false")
    }
    var lastposition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func update(_ currentTime: TimeInterval) {
        if Direction == "RIGHT"{
            player.run(SKAction.move(by: CGVector(dx: 3, dy: 0), duration: 0.1))
            print ("YEET")
        } else if Direction == "LEFT"{
           player.run(SKAction.move(by: CGVector(dx: -3, dy: 0), duration: 0.1))
        } else if Direction == "UP"{
            
        }
    }
    
}








