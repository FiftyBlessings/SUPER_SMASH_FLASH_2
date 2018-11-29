
import Foundation
import SpriteKit

var playerWalkingFrames: [SKTexture] = []
extension SKSpriteNode {
    


    func buildplayer(Atlas: String) {
    let playerAnimatedAtlas = SKTextureAtlas(named: Atlas)
    var walkFrames: [SKTexture] = []
    
    let numImages = playerAnimatedAtlas.textureNames.count
    for i in 1...numImages {
        let playerTextureName = ("\(Atlas)\(i)")
        walkFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName))
    }
    playerWalkingFrames = walkFrames
    let firstFrameTexture = playerWalkingFrames[0]
    self.texture = firstFrameTexture
}
    
func animateplayer() {
    self.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: false,
                         restore: true)),
               withKey:"walkingInPlaceplayer")
}
    func StrafeLeft() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "L_LLOYD_WALK")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
    func StrafeRight() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "R_LLOYD_WALK")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
    func Jump() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "LLOYD_WALK")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
    func Duck() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "LLOYD_WALK")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
    func IdleLeft() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "L_LLOYD_IDLE")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
    func IdleRight() {
        let lastposition = self.position
        let parent: SKNode = self.parent!
        self.removeFromParent()
        buildplayer(Atlas: "R_LLOYD_IDLE")
        animateplayer()
        parent.addChild(self)
        self.position = lastposition
        print("This Code Is Being Executed")
    }
}
