import SpriteKit
class TaimanStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 50
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeMetalSlime()
    }
    
    override func makeBoss(danjon_type : String){
        var enemy = BossGhostNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        enemy.physicsBody!.velocity = CGVectorMake(-45, -330)
        self.addChild(enemy)
    }
}