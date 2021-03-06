//ダンジョン選択画面
import SpriteKit
class MapScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        
        setCenterButton("スライムの洞窟",   key_name: "slime",     point_y: point_y1)
        setCenterButton("スカーフ山",      key_name: "tanuki",     point_y: point_y2)
        setCenterButton("アノーレ・ロンド遺跡",        key_name: "golem",     point_y: point_y3)
        setCenterButton("サイレント昼",     key_name: "dojo_g",    point_y: point_y4)
        setCenterButton("ラスボス（魔王城）", key_name: "maou",    point_y: point_y5)
        setCenterButton("寄り道をする", key_name: "next",    point_y: point_y6)        
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
        } else if name == "slime" || name == "tanuki" || name == "golem" || name == "dojo_g" {
            CommonData.setData("stage_name", value: name)
            changeScene(MapPrepareScene(size: self.frame.size), tr: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1))
        } else if name == "maou" {
            if CommonData.getDataByInt("mao_key") == 1 {
                CommonData.setData("stage_name", value: name)
                changeScene(MapPrepareScene(size: self.frame.size), tr: SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1))
            } else {
                showAlert("鍵がかかっていて入れない！", text: "魔王め、なんて用心深いんだ", ok_text: "他の場所へ行こう")
            }
        }
    }
    
    func goNext(){
        let secondScene = Map2Scene(size: self.frame.size)
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
