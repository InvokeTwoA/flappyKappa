// 街画面
import SpriteKit
class ShopScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*3)
        
        setButton("武器屋に行くぜ", key_name: "weapon_shop", point_y: point_y1)
        setButton("酒でも飲むか！", key_name: "bar", point_y: point_y2)
        setButton("働くでござる", key_name: "work", point_y: point_y3)
        setButton("転職するか", key_name: "job", point_y: point_y4)
        setBackButton("こんな場所にもう用はない！")
    }
    
    //「転職」ボタンを設置
    func setJobChangeButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*4))
        let startButton: SKSpriteNode = CommonUI.normalButton("転職するか", name: "job", point: point)
        self.addChild(startButton)
    }
    
    override func checkTochEvent(name: String) {
        if name == "job" {
            goJobScene()
        } else if name == "bar" {
            goBarScene()
        } else if name == "weapon_shop" {
            goWeaponShopScene()
        } else if name == "work" {
            goWorkScene()
        } else if name == "back" {
            goGameScene()
        }
    }
    
    // 冒険へ
    func goGameScene(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    func goBarScene(){
        changeNickname("アル中", percent: 2)
        let secondScene = BarScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goWorkScene(){
        changeNickname("真面目な", percent: 2)
        let secondScene = WorkScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goWeaponShopScene(){
        let secondScene = ShopWeaponScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    // 転職画面へ
    func goJobScene(){
        let secondScene = JobScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}

