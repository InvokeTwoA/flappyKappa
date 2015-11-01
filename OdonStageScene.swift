import SpriteKit
class OdonStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 1600
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeSister(80)
    }
    
    override func hitDownWorld(firstBody: SKPhysicsBody) {
        makeSpark(firstBody.node?.position)
        let damage = 1
        damaged(damage, point: firstBody.node!.position, color: UIColor.redColor())
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = GolemNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}