import SpriteKit

class ShadowNode: SKSpriteNode {
    let width = 32
    let height = 32
    let half_height :Int = 16
    
    class func makeEnemy(danjon_type: String) -> ShadowNode {
        let enemy : ShadowNode = ShadowNode(imageNamed: "kappa_32_32")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 2
        } else if danjon_type == "special" {
            value = 3
        }
        enemy.userData =
            [
                "hp" : CommonData.getDataByInt("hp")*value,
                "str": CommonData.getDataByInt("str") ,
                "def": CommonData.getDataByInt("def"),
                "mdef": 50,
                "gold": CommonData.getDataByInt("gold"),
                "name": "鏡の騎士"
        ]
        enemy.name = "boss"
        enemy.setPhysic()
        return enemy
    }
    
    // 物理を適用
    func setPhysic() {
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(CGFloat(width), CGFloat(height)))
        physic.affectedByGravity = true
        physic.allowsRotation = false
        physic.categoryBitMask = enemyCategory
        physic.contactTestBitMask = fireCategory | swordCategory | worldCategory
        physic.collisionBitMask = worldCategory | wallCategory | downWorldCategory | horizonWorldCategory
        physic.linearDamping = 0
        physic.friction = 0
        self.physicsBody = physic
    }
}
