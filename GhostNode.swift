import SpriteKit

class GhostNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    var _dx :Int = 36
    
    class func makeEnemy() -> GhostNode {
        var enemy = GhostNode(imageNamed: "ghost")
        
        enemy._dx = 36
        enemy.userData =
            [
                "hp" : 8,
                "str" : 3,
                "def": 99,
                "mdef": 0,
                "gold": 3,
                "score": 1
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
        physic.collisionBitMask = heroCategory | worldCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
    
    
    // タイトルでただフワフワしてるだけのスライム
    class func makeDemo()-> GhostNode {
        var enemy = GhostNode(imageNamed: "ghost")
        enemy.zPosition = 999
        
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(32), CGFloat(32)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = blockCategory
        physic.collisionBitMask = worldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.restitution = 1.0
        physic.friction = 0
        physic.velocity = CGVectorMake(CGFloat(-1*64), 0)
        enemy.physicsBody = physic
        
        return enemy
    }
}