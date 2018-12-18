
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
    
    func animateplayer(_ Repeats: Bool) {
        if Repeats == true {
            self.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: true,
                         restore: true)),
               withKey:"walkingInPlaceplayer")
        } else if Repeats == false {
            self.run(
                SKAction.animate(with: playerWalkingFrames,
                                 timePerFrame: 0.1,
                                 resize: true,
                                 restore: true),
                     withKey:"walkingInPlaceplayer")
        }
}
    func StrafeLeft() {
        buildplayer(Atlas: "L_LLOYD_WALK")
        animateplayer(true)
    }
    
    func StrafeRight() {
        buildplayer(Atlas: "R_LLOYD_WALK")
        animateplayer(true)
    }
    
    func Jump() {
        buildplayer(Atlas: "UR_LLOYD_JUMP")
        animateplayer(false)
    }
    
    func Duck() {
        buildplayer(Atlas: "LLOYD_WALK")
        animateplayer(true)
    }
    
    func IdleLeft() {
        buildplayer(Atlas: "L_LLOYD_IDLE")
        animateplayer(true)
    }
    
    func IdleRight() {
        buildplayer(Atlas: "R_LLOYD_IDLE")
        animateplayer(true)
    }
    func AttackRight() {
        buildplayer(Atlas: "R_Lloyd_AttackStanding")
        animateplayer(false)
    }
    func AttackLeft() {
        buildplayer(Atlas: "L_Lloyd_AttackStanding")
        animateplayer(false)
    }
    func Fall() {
        
    }
    
}
