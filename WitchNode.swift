import SpriteKit

class WitchNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    class func makeEnemy(danjon_type: String) -> WitchNode {
        var enemy : WitchNode = WitchNode(imageNamed: "witch_32_32")
        let value : Int
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        } else {
            value = 1
        }
        enemy.userData =
            [
                "hp" : 15*value,
                "str" : 4,
                "def": 2,
                "gold": 8,
                "score": 20,
                "name" : "魔法使い"
        ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = false
        physic.allowsRotation = true
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = heroCategory | worldCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(CGFloat(40), 0)
        self.physicsBody = physic
    }
    
    // タイトルでただいるだけ
    class func makeDemo()-> WitchNode {
        var enemy = WitchNode(imageNamed: "witch_32_32")
        enemy.zPosition = 999
        return enemy
    }
    
}
