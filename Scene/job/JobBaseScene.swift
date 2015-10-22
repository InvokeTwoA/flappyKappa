// 転職画面の親クラス
import Foundation

import SpriteKit

class JobBaseScene: BaseScene {
    var _job_name : String = "職業名"
    var _skill_name : String = "スキル名"
    var _skill_explain : String = "スキル説明"
    
    var _str_up : Int = 0
    var _def_up : Int = 0
    var _int_up : Int = 0
    var _agi_up : Int = 0
    var _pri_up : Int = 0
    var _luck_up : Int = 0
    
    override func didMoveToView(view: SKView) {
        setJobData()
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        var titleLabel : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_bold)
        titleLabel.text = _job_name
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight))
        titleLabel.position = point
        self.addChild(titleLabel)
        
        var explainLabel : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        explainLabel.text = "スキル: [\(_skill_name)] "
        explainLabel.fontSize = 18
        let point2 : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point.y - CGFloat(CommonConst.textBlankHeight))
        explainLabel.position = point2
        self.addChild(explainLabel)
        
        var hatenaBox = SKSpriteNode(imageNamed: "hatena.gif")
        hatenaBox.name = "hatena"
        hatenaBox.position = CGPointMake(point2.x + CGFloat(explainLabel.frame.width/2) + 30, point2.y + 10)
        self.addChild(hatenaBox)
        
        /** 成長率 **/
        var label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "成長率"
        label.fontSize = 18
        let point3 : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:point2.y - CGFloat(CommonConst.textBlankHeight*2))
        label.position = point3
        self.addChild(label)
        
        let point4_y = point3.y - CGFloat(CommonConst.textBlankHeight)
        let point5_y = point4_y - CGFloat(CommonConst.textBlankHeight)
        let point6_y = point5_y - CGFloat(CommonConst.textBlankHeight)
        let point7_y = point6_y - CGFloat(CommonConst.textBlankHeight)
        let point8_y = point7_y - CGFloat(CommonConst.textBlankHeight)
        let point9_y = point8_y - CGFloat(CommonConst.textBlankHeight)

        showStatus("筋力",    value: _str_up,    point_y: point4_y)
        showStatus("体力",    value: _def_up,    point_y: point5_y)
        showStatus("知恵",    value: _int_up,    point_y: point6_y)
        showStatus("精神",    value: _pri_up,    point_y: point7_y)
        showStatus("敏捷",    value: _agi_up,    point_y: point8_y)
        showStatus("幸運",    value: _luck_up,   point_y: point9_y)
        
        setYesButton()
        setBackButton()
    }
    
    func showStatus(text : String, value : Int, point_y: CGFloat){
        var label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        label.text = "\(text) : \(value)"
        label.fontSize = 18
        label.position = CGPointMake(CGRectGetMidX(self.frame), point_y)
        self.addChild(label)
    }
    
    func setJobData(){
        // 職業ごとの値を設定
    }
    
    func setJobSkill(){
        // 職業のスキルを設定
    }

    func changeNickname(){
        // 異名が一定確率で変更
    }
    
    func setYesButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.textBlankHeight*3))
        let startButton: SKSpriteNode = CommonUI.normalButton("転職する！", name: "yes", point: point)
        self.addChild(startButton)
    }
    
    func setBackButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.textBlankHeight))
        let startButton: SKSpriteNode = CommonUI.normalButton("やっぱやめた", name: "back", point: point)
        self.addChild(startButton)
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "yes" {
            changeJob()
        } else if name == "hatena" {
            explainMessage()
        } else if name == "back" {
            goBack()
        }
    }
    
    func explainMessage(){
        let alert = CommonUI.normalAlert("スキル[\(_skill_name)]", message: _skill_explain, okMessage: "なるほどー")
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    // 成長率を変更
    func changeStatus(){
        CommonData.setData("str_up",    value: _str_up)
        CommonData.setData("def_up",    value: _def_up)
        CommonData.setData("int_up",    value: _int_up)
        CommonData.setData("pri_up",    value: _pri_up)
        CommonData.setData("agi_up",    value: _agi_up)
        CommonData.setData("luck_up",   value: _luck_up)
    }
    
    // 冒険へ
    func changeJob(){
        changeNickname()
        
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"転職しますか？",
            message: "転職するとスキルや成長率が変わります",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        // Cancel 一つだけしか指定できない
        let cancelAction: UIAlertAction = UIAlertAction(title: "やっぱやめた。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
        })
        
        // Default 複数指定可
        let defaultAction: UIAlertAction = UIAlertAction(title: "転職するぜ！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.forgetSkill()
                self.setJobSkill()
                self.changeStatus()
                self.jobChanged()
        })
        
        // AddAction 記述順に反映される
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    // 転職完了
    func jobChanged(){
        CommonData.setData("job", value: _job_name)        
        let nextScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeScene(nextScene, tr: tr)
    }
    
    // 戻る
    func goBack(){
        let secondScene = JobScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

