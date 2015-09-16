import SpriteKit

class TanukiNode: SKSpriteNode {
    let width = 100
    let height = 100
    let half_height :Int = 50
    
    class func makeEnemy() -> TanukiNode {
        var enemy : TanukiNode = TanukiNode(imageNamed: "tanuki")
        enemy.zPosition = 999
        enemy.userData =
            [
                "hp" : 100,
                "str" : 1,
                "def": 3,
                "mdef": 3,
                "gold": 600,
                "score": 600
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
}
