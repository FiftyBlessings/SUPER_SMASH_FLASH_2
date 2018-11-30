import SpriteKit

class GameScene: SKScene {
    
var player = SKSpriteNode()
var platform = SKSpriteNode()
let colorService = ColorService()
    
    var N = SKSpriteNode()
    var  S = SKSpriteNode()
    var E = SKSpriteNode()
    var W = SKSpriteNode()
    var NE = SKSpriteNode()
    var SE = SKSpriteNode()
    var NW = SKSpriteNode()
    var SW = SKSpriteNode()
    
private var playerWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        colorService.delegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4.8)
        platform.position = CGPoint(x: 50, y: 0)
       platform.physicsBody = SKPhysicsBody()
        platform.physicsBody?.affectedByGravity = false
        platform.size = CGSize(width: 1400, height: 40)
        
        player.physicsBody?.collisionBitMask = 500
        platform.physicsBody?.collisionBitMask = 30
        
        platform.color = .black
        buildplayer(Atlas: "R_LLOYD_IDLE")
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
    
    func moveto(_ dircection: CGPoint) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touchlocation = touches.first?.location(in: self)
        if let node = self.nodes(at: touchlocation!).first {
    
        }
        
        for _ in touches {}
        touch = true
        colorService.send(colorName: "true")
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
   
}
    
        
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastposition = player.position
        player.removeFromParent()
        buildplayer(Atlas: "R_LLOYD_IDLE")
        animateplayer()
        self.addChild(player)
        player.position = lastposition
        touch = false
        colorService.send(colorName: "false")
    }
    var lastposition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func update(_ currentTime: TimeInterval) {
        if (touch) {
            player.position = CGPoint(x: Int(player.position.x) + 1, y: Int(player.position.y))
        } else {
            
        }
    }
    
}








