import SpriteKit
class SeizonStageScene: PlayScene {
    
    override func setStageValue() {
        _distance = 1500
        _hp = 1
        _maxhp = 1
        changeLifeLabel()
        changeLifeBar()
    }
    
    // 敵を作成
    override func generateEnemy(){
        makeApple()
        makeBlock(10)
        makeSlime(50)
        makeFighter(15)
        makeSister(20)
        makeSuperSlime(10)
    }
    
    override func makeBoss(danjon_type : String){
        let enemy = GolemNode.makeEnemy(_danjon_type)
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - CGFloat(enemy.half_height - 2), CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + enemy.half_height))
        enemy.position = point
        _bossName = enemy.userData?.valueForKey("name") as! String
        self.addChild(enemy)
    }
}