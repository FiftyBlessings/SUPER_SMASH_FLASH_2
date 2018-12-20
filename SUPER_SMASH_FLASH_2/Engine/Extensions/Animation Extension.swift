
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
    
    func animateplayer(_ Repeats: Bool, key: String) {
        if Repeats == true {
            self.run(SKAction.repeatForever(
        SKAction.animate(with: playerWalkingFrames,
                         timePerFrame: 0.1,
                         resize: true,
                         restore: true)),
               withKey:(key))
        } else if Repeats == false {
            self.run(
                SKAction.animate(with: playerWalkingFrames,
                                 timePerFrame: 0.1,
                                 resize: true,
                                 restore: true),
                     withKey:(key))
        }
}
        func Strafe(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_WALK")
            animateplayer(true, key: "WALK")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_WALK")
            animateplayer(true, key: "WALK")
        }
    }
        func Jump(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "UR_LLOYD_JUMP")
            animateplayer(false, key: "JUMP")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "UL_LLOYD_JUMP")
            animateplayer(false, key: "JUMP")
        }
    }
        func Duck(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_DUCK")
            animateplayer(true, key: "DUCK")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_DUCK")
            animateplayer(true, key: "DUCK")
            }
    }
    func Idle(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_IDLE")
            animateplayer(true, key: "IDLE")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_IDLE")
            animateplayer(true, key: "IDLE")
        }
    }
    func Attack(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_Lloyd_AttackStanding")
            animateplayer(false, key: "ATTACK")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_Lloyd_AttackStanding")
            animateplayer(false, key: "ATTACK")
        }
    }
    func Fall(_ Direction: String) {
        if Direction == "RIGHT" {
            buildplayer(Atlas: "R_LLOYD_FALLING")
            animateplayer(true, key: "FALL")
        } else if Direction == "LEFT" {
            buildplayer(Atlas: "L_LLOYD_FALLING")
            animateplayer(true, key: "FALL")
        }
    }
}
