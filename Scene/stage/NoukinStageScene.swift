import SpriteKit
class NoukinStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 1200
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(12)
        makeSuperSlime(35)
        makeSister(40)
    }
    
    override func setFireBall(location: CGPoint){
        return
    }
    
    override func makeBoss(danjon_type : String){
        var enemy = KnightNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}