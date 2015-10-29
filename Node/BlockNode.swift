import SpriteKit

class BlockNode: SKSpriteNode {

    let width: CGFloat = 32
    let height: CGFloat = 32
    let half_height : CGFloat = 16
    
    class func makeBlock() -> BlockNode {
//        var node : BlockNode = BlockNode(imageNamed: "block")
//        var node : BlockNode = BlockNode(color: UIColor.yellowColor(), size: size)
        let node : BlockNode = BlockNode(imageNamed: "block.png")
        node.name = "block"
        node.setPhysic()
        node.zPosition = 3
/*
        let point : CGPoint = CGPoint(x:CGRectGetMidX(frame), y: CGRectGetMinY(self.frame) + CGFloat(CommonConst.footerHeight + CommonConst.groundHeight/2))
        let size : CGSize = CGSizeMake(CGRectGetMaxX(self.frame), CGFloat(CommonConst.groundHeight))
        var background : SKSpriteNode = SKSpriteNode(color: UIColor.grayColor(), size: size)
        background.position = point
        background.zPosition = 100
        background.physicsBody = CommonUI.setWorldPhysic(size)
*/
        return node
    }
    
    func setPhysic(){
        let physic = SKPhysicsBody(rectangleOfSize: CGSizeMake(width, height))
        physic.affectedByGravity = false
        physic.allowsRotation = false
        physic.categoryBitMask = blockCategory
        physic.collisionBitMask = 0
        physic.linearDamping = 0
        physic.friction = 0
        physic.velocity = CGVectorMake(-20, 0)
        self.physicsBody = physic
    }
    
}
