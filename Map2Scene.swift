//ダンジョン選択画面 その２
import SpriteKit
class Map2Scene: BaseScene {
    var _nextScene : SKScene = SlimeStageScene(size: CGSizeMake(1,1))
    let _tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1)
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        
        setCenterButton("脳筋ダンジョン",   key_name: "noukin",     point_y: point_y1)
        setCenterButton("FE闘技場",      key_name: "taiman",     point_y: point_y2)
        setCenterButton("魔法科中学校",        key_name: "maho",     point_y: point_y3)
        setCenterButton("デスマス城",     key_name: "kabe",    point_y: point_y4)
        if(CommonData.getDataByInt("story") > 1){
            setCenterButton("無限の住人",     key_name: "mugen",    point_y: point_y5)
        }

        setBackButton("街に戻るンゴ")
    }
    
    override func setSlimeDemo() {
        return
    }
    
    override func checkTochEvent(name: String) {
        if name == "back" {
            backAdventure()
        } else if name == "kappa" {
        } else if name == "sword" {
        
        } else {
            CommonData.setData("stage_name", value: name)
            _nextScene = MapPrepareScene(size: self.frame.size)
            changeScene(self._nextScene, tr: self._tr)
        }
    }
    
    func backAdventure(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
}