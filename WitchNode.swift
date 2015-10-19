import SpriteKit

class WitchNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    class func makeEnemy() -> WitchNode {
        var enemy : WitchNode = WitchNode(imageNamed: "witch_64_64")
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
    
    // タイトルでただいるだけ
    class func makeDemo()-> WitchNode {
        var enemy = WitchNode(imageNamed: "witch_64_64")
        enemy.zPosition = 999
        return enemy
    }
    
}
