import SpriteKit

class BossGhostNode: SKSpriteNode {
    /*
    let width = 118
    let height = 94
    let half_height :Int = 59
    */
    let width = 64
    let height = 64
    let half_height :Int = 32
    
    class func makeEnemy(danjon_type: String) -> BossGhostNode {
        var enemy : BossGhostNode = BossGhostNode(imageNamed: "ghost_64_64")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        }
        enemy.userData =
            [
                "hp" : 77*value,
                "str" : 7,
                "def": 100,
                "mdef": 1,
                "gold": 100,
                "score": 500,
                "name": "元勇者"
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
        physic.velocity = CGVectorMake(-25, -330)
        self.physicsBody = physic
    }
}
