import SpriteKit
class TutorialStageScene: PlayScene {

    // 敵を作成
    override func generateNormalEnemy(){
        makeApple()
        makeBlock(7)
    }
    
    override func generateHardEnemy(){
        makeApple()
        makeBlock(6)
    }
    
    override func generateSpecialEnemy(){
        makeBlock(5)
    }

    // チュートリアルなので剣は使えない
    override func setSword(from: CGPoint, to: CGPoint){
        return
    }
    
    // チュートリアルなのでファイアボールは使えない
    override func setFireBall(location: CGPoint){
        return
    }
}