import SpriteKit
class TutorialStageScene: PlayScene {

    override func setStageValue() {
        _distance = 1000
    }
    
    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(7)
        makeSlime(30)
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(6)
        makeSlime(40)
    }
    
    override func generateSpecialEnemy(){
        makeBlock(5)
        makeSlime(100)
        makeSuperSlime(40)
    }
    
    override func makeBoss(){
        var enemy = BeerNode.makeEnemy()
        let point : CGPoint = CGPointMake(CGRectGetMaxX(self.frame) - 50 ,CGFloat(CommonConst.footerHeight + enemy.half_height + 14))
        enemy.position = point
        self.addChild(enemy)
    }
    
    /*
    // チュートリアルなので剣は使えない
    override func setSword(from: CGPoint, to: CGPoint){
        return
    }
    
    // チュートリアルなのでファイアボールは使えない
    override func setFireBall(location: CGPoint){
        return
    }
    */
}