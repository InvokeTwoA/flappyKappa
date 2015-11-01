import SpriteKit

class MaoNode: SKSpriteNode {
    let width = 64
    let height = 64
    let half_height :Int = 32
    
    class func makeEnemy(danjon_type: String) -> MaoNode {
        let enemy : MaoNode = MaoNode(imageNamed: "maou_64_64")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 2
        } else if danjon_type == "special" {
            value = 3
        }
        let hp : Int =  CommonData.getDataByInt("day")*value
        enemy.userData =
            [
                "hp" : hp,
                "str" : 1,
                "def": 66,
                "mdef": 50,
                "gold": 1000,
                "score": 1000,
                "name": "魔王"
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
        physic.contactTestBitMask = fireCategory | swordCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        physic.restitution = 1.0
        self.physicsBody = physic
    }
    
    class func makeDemo()-> MaoNode {
        let enemy = MaoNode(imageNamed: "maou_32_32")
        enemy.zPosition = 999
        return enemy
    }
}
