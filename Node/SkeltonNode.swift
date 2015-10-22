import SpriteKit

class SkeltonNode: SKSpriteNode {
    
    var _lv : Int = 1
    let _width = 32
    let _height = 32
    
    class func makeEnemy(danjon_type : String) -> SkeltonNode {
        var enemy : SkeltonNode = SkeltonNode(imageNamed: "skelton_32_32")
        let value : Int
        if danjon_type == "hard" {
            value = 3
        } else if danjon_type == "special" {
            value = 2
        } else {
            value = 1
        }
        enemy.userData =
            [
                "hp" : 9*value,
                "str" : 4,
                "def": 10,
                "mdef": 2,
                "gold": 6,
                "score": 30,
                "name" : "がいこつ"
        ]
        enemy.name = "enemy"
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(_width), CGFloat(_height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        physic.velocity = CGVectorMake(-24, 0)
        
        self.physicsBody = physic
    }
    
    // タイトルでただいるだけ
    class func makeDemo()-> WitchNode {
        var enemy = WitchNode(imageNamed: "skelton_32_32")
        enemy.zPosition = 999
        return enemy
    }
}
