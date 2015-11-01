import SpriteKit

class GolemNode: SKSpriteNode {
    /*
    let width = 118
    let height = 94
    let half_height :Int = 59
    */
    let width = 64
    let height = 64
    let half_height :Int = 32

    
    class func makeEnemy(danjon_type: String) -> GolemNode {
//        var enemy : GolemNode = GolemNode(imageNamed: "golem")
                let enemy : GolemNode = GolemNode(imageNamed: "skelton_64_64")
        enemy.zPosition = 999
        var value : Int = 1
        if danjon_type == "hard" {
            value = 2
        } else if danjon_type == "special" {
            value = 3
        }
        enemy.userData =
            [
                "hp" : 100*value,
                "str" : 6,
                "def": 6,
                "mdef": 50,
                "gold": 40,
                "score": 500,
                "name": "骸骨巨人"
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
        physic.velocity = CGVectorMake(-40, -40)
        self.physicsBody = physic
    }
}
