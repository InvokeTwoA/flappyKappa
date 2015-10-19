import SpriteKit

class FighterNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    class func makeEnemy() -> FighterNode {
        var enemy : FighterNode = FighterNode(imageNamed: "g_fighter")
        enemy.userData =
            [
                "hp" : 8,
                "str" : 2,
                "def": 2,
                "gold": 3,
                "score": 20
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
}
