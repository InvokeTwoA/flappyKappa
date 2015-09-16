import SpriteKit

class MaoNode: SKSpriteNode {
    let width = 32
    let height = 64
    let half_height :Int = 32
    
    class func makeEnemy() -> MaoNode {
        var enemy : MaoNode = MaoNode(imageNamed: "hero")
        enemy.zPosition = 999
        enemy.userData =
            [
                "hp" : 1000,
                "str" : 1,
                "def": 50,
                "mdef": 50,
                "gold": 10000,
                "score": 1000
        ]
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-350, -10)
        self.physicsBody = physic
    }
}
