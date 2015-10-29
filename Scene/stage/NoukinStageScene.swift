import SpriteKit
class NoukinStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 3000
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(13)
        makeSuperSlime(15)
        makeSkelton(20)
        makeMetalSlime()
    }
    
    override func setFireBall(location: CGPoint){
        return
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = KnightNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}