import SpriteKit
class TanukiStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 1600
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(20)
        makeSlime(30)
        makeGhost(15)
        makeFighter(10)
    }
    
    override func makeBoss(danjon_type : String){
        var enemy = KnightNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}