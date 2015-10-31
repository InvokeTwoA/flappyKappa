// 村の発展画面
import SpriteKit
class DevelopScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight*2)
        
        let str_dev = CommonData.getDataByInt("str_dev")
        let def_dev = CommonData.getDataByInt("def_dev")
        let int_dev = CommonData.getDataByInt("int_dev")
        let pri_dev = CommonData.getDataByInt("pri_dev")
        let luck_dev = CommonData.getDataByInt("luck_dev")
        
        setCenterText("どの施設を発展させますか？", key_name: "hoge", point_y: point_y1)
        setCenterButton("武器屋 LV\(str_dev)", key_name: "str_dev", point_y: point_y2)
        setCenterButton("プロレス屋 LV\(def_dev)", key_name: "def_dev", point_y: point_y3)
        setCenterButton("学校 LV\(int_dev)", key_name: "int_dev", point_y: point_y4)
        setCenterButton("病院 LV\(pri_dev)", key_name: "pri_dev", point_y: point_y5)
        setCenterButton("雀荘 LV\(luck_dev)", key_name: "luck_dev", point_y: point_y6)
        setBackButton("帰るぜ")
    }
    
    
    override func checkTochEvent(name: String) {
        if name == "back" {
            goShopScene()
        } else {
            develop(name)
        }
    }
    
    func develop(key_name : String){
        if _gold < 1000 {
            showAlert("お金が足りないよ", text: "村の発展には1000ゴールド必要です", ok_text: "しょんぼり")
        } else {
            if CommonData.getDataByInt(key_name) <= 49 {
                CommonData.plus(key_name, value: 1)
                CommonData.minus("gold", value: 1000)
                reloadScene()
            } else {
                showAlert("これ以上は上がりません", text: "施設のレベル限界は50までです", ok_text: "しょんぼり")
            }
        }
    }
        
    func updateText(key: String, display_name: String){
        let label = childNodeWithName(key) as! SKLabelNode
        let lv = CommonData.getDataByInt(key)
        label.text = "\(display_name) LV\(lv)"
    }
    
    func reloadScene(){
        updateGoldText()
        
        updateText("str_dev", display_name: "武器屋")
        updateText("def_dev", display_name: "プロレス屋")
        updateText("int_dev", display_name: "学校")
        updateText("pri_dev", display_name: "病院")
        updateText("luck_dev", display_name: "雀荘")
    }
    
    // 冒険へ
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
}

