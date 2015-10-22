import SpriteKit

class KnightNode: SKSpriteNode {
    let width = 64
    let height = 64
    let half_height :Int = 32
    
    class func makeEnemy(danjon_type : String) -> KnightNode {
        var enemy : KnightNode = KnightNode(imageNamed: "knight_64_64")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        }
        enemy.userData =
            [
                "hp" : 66*value,
                "str" : 3,
                "def": 3,
                "mdef": 3,
                "gold": 20,
                "score": 600,
                "name": "留年騎士"
        ]
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-330, -25)
        self.physicsBody = physic
    }
    
    // タイトルでただいるだけ
    class func makeDemo()-> WitchNode {
        var enemy = WitchNode(imageNamed: "knight_32_32")
        enemy.zPosition = 999
        return enemy
    }
}
