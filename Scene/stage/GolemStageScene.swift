import SpriteKit
class GolemStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 1800
    }

    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeAllBlock(7)
        makeGhost(5)
        makeFighter(4)
        makeSkelton(3)
    }

    override func makeBoss(danjon_type : String){
        let enemy = GolemNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}