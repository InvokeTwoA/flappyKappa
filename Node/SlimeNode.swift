import SpriteKit

class SlimeNode: SKSpriteNode {
    
    let width = 32
    let height = 32
    let half_height = 16
    
    var _dx :Int = 36

    class func makeEnemy() -> SlimeNode {

        var enemy : SlimeNode = SlimeNode(imageNamed: "slime")
        enemy._dx = 36
        enemy.userData =
            [
                "hp" : 4,
                "str" : 1,
                "def": 1,
                "mdef": 0,
                "gold": 1,
                "score": 1
            ]
        enemy.name = "enemy"
        enemy.zPosition = 999
        enemy.setPhysic()
        return enemy
    }
    
    class func makeSuperEnemy() -> SlimeNode {
        var enemy : SlimeNode = SlimeNode(imageNamed: "green_slime")
        enemy._dx = 95
        enemy.userData =
            [
                "hp" : 6,
                "str" : 10,
                "def": 2,
                "mdef": 0,
                "gold": 20,
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
        physic.velocity = CGVectorMake(CGFloat(-1*_dx), 0)
        self.physicsBody = physic
    }
}