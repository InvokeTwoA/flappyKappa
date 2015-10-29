//ゲームオーバー画面
import SpriteKit
class GameOverScene: BaseScene {
    
    var _hero1 :String = ""
    var _hero2 :String = ""
    var _hero3 :String = ""
    
    override func didMoveToView(view: SKView) {
        CommonData.dayPast()
        setBaseSetting()
        
//        self.backgroundColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:1.0)

        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight*2)
        let y4 = y3 - CGFloat(CommonConst.textBlankHeight)
        let y5 = y4 - CGFloat(CommonConst.textBlankHeight*3)
        setCenterText("残念！　君の冒険は", key_name: "text1", point_y: y1)
        setCenterText("ここで終わってしまった。", key_name: "text1", point_y: y2)

        setCenterText("もし生まれ変わるるなら", key_name: "text1", point_y: y3)
        setCenterText("次こそ真の勇者に……", key_name: "text1", point_y: y4)
        
        setCenterText("TO BE CONTINUE..", key_name: "text1", point_y: y5)
        
        CommonData.plus("birth", value: 1)
        CommonData.deadStatus()
        setBackButton("がんばリベンジだ！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goStatus()
        }
    }
    
    override func saveMoney() {
        _gold = 0
        return
    }
    
    
    func goStatus(){
        let nextScene = StatusScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeSceneWithLongDuration(nextScene, tr: tr, duration: 1)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
