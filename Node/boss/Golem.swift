import SpriteKit

class GolemNode: SKSpriteNode {
    let width = 118
    let height = 94
    let half_height :Int = 59
    
    class func makeEnemy() -> GolemNode {
        var enemy : GolemNode = GolemNode(imageNamed: "golem")
        enemy.zPosition = 999
        enemy.userData =
            [
                "hp" : 100,
                "str" : 3,
                "def": 50,
                "mdef": 50,
                "gold": 500,
                "score": 500
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
        physic.collisionBitMask = worldCategory | wallCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-40, -40)
        self.physicsBody = physic
    }
}
