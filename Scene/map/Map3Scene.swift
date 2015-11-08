//ダンジョン選択画面 その２
import SpriteKit
class Map3Scene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        
        setCenterButton("オデン教会", key_name: "odon",   point_y: point_y1)
        setCenterButton("生存率3%",      key_name: "seizon",     point_y: point_y2)
        setCenterButton("ホワイトベース",  key_name: "white", point_y: point_y3)
        if(CommonData.getDataByInt("story") > 1){
            setCenterButton("１対１の決闘",    key_name: "kettou", point_y: point_y4)
            setCenterButton("無限の住人",     key_name: "mugen",  point_y: point_y5)
        } else {
            setCenterText("???",    key_name: "text", point_y: point_y4)
            setCenterText("???",     key_name: "text",  point_y: point_y5)
        }
        
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
        } else if name == "text"{
        } else if name == "kappa" {
        } else if name == "sword" {
            
        } else {
            CommonData.setData("stage_name", value: name)
            changeScene(MapPrepareScene(size: self.frame.size), tr: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1))
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
