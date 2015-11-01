import Social
// ステータス表示
import SpriteKit
class StatusScene: BaseScene {
    var _cost : Int = 0
    var _lv : Int = CommonData.getDataByInt("lv")
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.1,green:0.0,blue:0.1,alpha:1.0)
        setBaseSetting()
        setCost()

        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight)
        let y4 = y3 - CGFloat(CommonConst.textBlankHeight)
        let y5 = y4 - CGFloat(CommonConst.textBlankHeight)
        let y6 = y5 - CGFloat(CommonConst.textBlankHeight)
        let y7 = y6 - CGFloat(CommonConst.textBlankHeight)
        let y8 = y7 - CGFloat(CommonConst.textBlankHeight)
        let y9 = y8 - CGFloat(CommonConst.textBlankHeight)
        let y10 = y9 -  CGFloat(CommonConst.textBlankHeight)
        let y11 = y10 - CGFloat(CommonConst.textBlankHeight)
        let y12 = y11 - CGFloat(CommonConst.textBlankHeight)
        
        
        let lvLabel : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        let lv : Int = CommonData.getDataByInt("lv")
        lvLabel.text = "LV : \(lv)"
        lvLabel.fontSize = CGFloat(CommonConst.font_size_normal)
        lvLabel.position = CGPointMake(CGRectGetMidX(self.frame), y1)
        self.addChild(lvLabel)

        setPicture("miku_32_32", key_name: "miku", point_y: y2)
        
        showStatusWithoutUp("hp", display_key: "HP",  y: y3)
        showStatus("str",   display_key: "筋力", y: y4)
        showStatus("def",   display_key: "体力", y: y5)
        showStatus("int",   display_key: "知恵", y: y6)
        showStatus("pri",   display_key: "精神", y: y7)
        showStatus("agi",   display_key: "敏捷", y: y8)
        showStatus("luck",  display_key: "幸運", y: y9)
        
        let label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "※ カッコ内の数字は成長率"
        label.fontSize = CGFloat(CommonConst.font_size_normal)
        label.position = CGPointMake(CGRectGetMidX(self.frame), y10)
        self.addChild(label)
        
        let costLabel : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        costLabel.name = "cost"
        costLabel.text = "LVアップに必要な金： \(_cost)"
        costLabel.fontSize = CGFloat(CommonConst.font_size_normal)
        costLabel.position = CGPointMake(CGRectGetMidX(self.frame), y11)
        self.addChild(costLabel)

        if CommonData.getDataByInt("gold") >= _cost {
            let lvUp = CommonUI.normalButton("LVアップする", name: "lv_up", point: CGPointMake(CGRectGetMidX(self.frame), y12))
            self.addChild(lvUp)
        }
        
        setBackButton("さて、行くか！")
    }
    
    func setCost(){
        _lv = CommonData.getDataByInt("lv")
        if _lv < 10 {
            _cost = _lv * 10
        } else {
            _cost = _lv * _lv * 2
        }
    }
    
    
    func setRealButton(point_y : CGFloat) {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame) - 70, y: point_y)
        let startButton: SKSpriteNode = CommonUI.normalButton("現実に戻る", name: "back", point: point)
        self.addChild(startButton)
    }
    
    func showStatus(key: String, display_key: String, y: CGFloat){
        let up_key = "\(key)_up"
        let label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        let val : Int = CommonData.getDataByInt(key)
        let up_val : Int = CommonData.getDataByInt(up_key)
        label.name = key
        label.text = "\(display_key) : \(val) (\(up_val))"
        label.fontSize = CGFloat(CommonConst.font_size_normal)
        label.position = CGPointMake(CGRectGetMidX(self.frame), y)
        self.addChild(label)
    }

    func updateStatus(key: String, display_key: String){
        let up_key = "\(key)_up"
        let label : SKLabelNode = childNodeWithName(key) as! SKLabelNode
        let val : Int = CommonData.getDataByInt(key)
        let up_val : Int = CommonData.getDataByInt(up_key)
        label.text = "\(display_key) : \(val) (\(up_val))"
    }
    
    func showStatusWithoutUp(key: String, display_key: String, y: CGFloat){
        let label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        let val : Int = CommonData.getDataByInt(key)
        label.name = key
        label.text = "\(display_key) : \(val)"
        label.fontSize = CGFloat(CommonConst.font_size_normal)
        label.position = CGPointMake(CGRectGetMidX(self.frame), y)
        self.addChild(label)
    }
    
    func updateStatusWithoutUp(key: String, display_key: String){
        let label : SKLabelNode = childNodeWithName(key) as! SKLabelNode
        let val : Int = CommonData.getDataByInt(key)
        label.text = "\(display_key) : \(val)"
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goGameSceneWithClose()
        } else if name == "lv_up" {
            levelUp()
        } else if name == "miku" {
            tweet()
        } else if name == "skill" {
            goSkill()
        }
    }
    
    // ドアを閉じるモーションでゲーム画面へ
    func goGameSceneWithClose(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.doorsCloseHorizontalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    // レベルアップを行うと画面更新のため、いまいる画面に遷移する
    func levelUp(){
        CommonData.lvUp()
        CommonData.minus("gold", value: _cost)
        setMoney()
        updateGoldText()
        setCost()
        
        updateStatusWithoutUp("hp", display_key: "HP")
        updateStatus("str",   display_key: "筋力")
        updateStatus("int",   display_key: "知恵")
        updateStatus("def",   display_key: "体力")
        updateStatus("pri",   display_key: "精神")
        updateStatus("agi",   display_key: "敏捷")
        updateStatus("luck",   display_key: "幸運")

        let costLabel : SKLabelNode = childNodeWithName("cost") as! SKLabelNode
        costLabel.text = "LVアップに必要な金： \(_cost)"
        if CommonData.getDataByInt("gold") < _cost {
            let lv_up = childNodeWithName("lv_up")
            lv_up?.removeFromParent()
        }

    }
    
    func tweet(){
        let twitterCmp : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        let nickname = CommonUI.displayName()
        twitterCmp.setInitialText("俺様が\(nickname)だ！！  #かっぱサーガ")
        
        let image = CommonUtil.screenShot(self.view!)
        twitterCmp.addImage(image)
        
        let currentViewController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController!
        //ツイート画面を表示
        currentViewController?.presentViewController(twitterCmp, animated: true, completion: nil)
    }
    
    // スキルページへと繊維。ページ数は1
    func goSkill(){
        CommonData.setData("skill_page", value: 1)
        let secondScene = SkillScene(size: self.frame.size)
        let tr = SKTransition.crossFadeWithDuration(1)
        changeScene(secondScene, tr: tr)
    }

    override func update(currentTime: CFTimeInterval) {
    }
}