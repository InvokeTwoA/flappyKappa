import SpriteKit

class SlimeNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16

    class func makeEnemy() -> SlimeNode {
        var enemy : SlimeNode = SlimeNode(imageNamed: "slime")
        enemy.userData =
            [
                "hp" : 4,
                "str" : 1,
                "def": 1,
                "mdef": 0,
                "gold": 500,
                "score": 10
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
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = heroCategory | worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(-36, 0)
        self.physicsBody = physic
    }
}
