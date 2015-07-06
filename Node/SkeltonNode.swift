import SpriteKit

class SkeltonNode: SKSpriteNode {
    
    var _lv : Int = 1
    let _width = 36
    let _height = 72
    
    class func makeEnemy(LV : Int) -> SkeltonNode {
        var enemy : SkeltonNode = SkeltonNode(imageNamed: "skelton")
        enemy.userData =
            [
                "hp" : 20+LV*3,
                "str" : 5+LV*2,
                "def": 20+LV*3,
                "mdef": 2,
                "gold": 3500+LV*100,
                "score": 30+LV*2
        ]
        enemy.name = "enemy"
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(_width), CGFloat(_height)))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = heroCategory | worldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(-24, 0)
        
        self.physicsBody = physic
    }
}
