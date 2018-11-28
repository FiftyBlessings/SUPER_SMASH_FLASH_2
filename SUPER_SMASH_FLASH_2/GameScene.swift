import SpriteKit

class GameScene: SKScene {
    
var player = SKSpriteNode()
var platform = SKSpriteNode()
let colorService = ColorService()

private var playerWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.8)
        platform.position = CGPoint(x: 50, y: 0)
       platform.physicsBody = SKPhysicsBody()
        platform.physicsBody?.affectedByGravity = false
        platform.size = CGSize(width: 1400, height: 40)
        
        player.physicsBody?.collisionBitMask = 500
        platform.physicsBody?.collisionBitMask = 30
        
        platform.color = .black
        buildplayer(Atlas: "LLOYD_IDLE")
        animateplayer()
    //    player.physicsBody = SKPhysicsBody()
    
        addChild(player)
        player.position = CGPoint(x: 250, y:100)
        addChild(platform)
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
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        player.StrafeLeft()
        
        for _ in touches {}
        touch = true
        colorService.send(colorName: "true")
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
   
}
    
        
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastposition = player.position
        player.removeFromParent()
        buildplayer(Atlas: "LLOYD_IDLE")
        animateplayer()
        self.addChild(player)
        player.position = lastposition
        touch = false
    }
    var lastposition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func update(_ currentTime: TimeInterval) {
        if (touch) {
            player.position = CGPoint(x: Int(player.position.x) + 1, y: 0)
        } else {
            
        }
    }
    
}

extension GameScene : ColorServiceDelegate {
    
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
  
        }
    }
    
    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "true":
                self.touch = true
                 self.player.removeFromParent()
                self.buildplayer(Atlas: "LLOYD_WALK")
                self.animateplayer()
                self.self.addChild(self.player)
            case "false":
                self.touch = false
                self.player.removeFromParent()
                self.buildplayer(Atlas: "LLOYD_IDLE")
                self.animateplayer()
                self.self.addChild(self.player)
                
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}






