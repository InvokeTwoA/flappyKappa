//ダンジョン選択画面 その２
import SpriteKit
class Map2Scene: BaseScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        
        setCenterButton("脳筋ダンジョン",   key_name: "noukin",     point_y: point_y1)
        setCenterButton("FE闘技場",      key_name: "taiman",     point_y: point_y2)
        setCenterButton("魔法科中学校",        key_name: "maho",     point_y: point_y3)
        setCenterButton("デスマス城",     key_name: "kabe",    point_y: point_y4)
        setCenterButton("もっと寄り道する", key_name: "next", point_y: point_y5)
        setBackButton("街に戻るンゴ")
    }
    
    override func setSlimeDemo() {
        return
    }
    
    override func setKappa(){
        return
    }
    
    override func setSword(from: CGPoint, to: CGPoint) {
        return
    }
    
    override func checkTochEvent(name: String) {
        if name == "back" {
            backAdventure()
        } else if name == "next" {
            goNext()
        } else if name == "noukin" || name == "taiman" || name == "maho" || name == "kabe" {
            CommonData.setData("stage_name", value: name)
            changeScene(MapPrepareScene(size: self.frame.size), tr: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1))
        }
    }
    
    func goNext(){
        let secondScene = Map3Scene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func backAdventure(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
}
