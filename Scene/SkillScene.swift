// スキル表示
import SpriteKit

class SkillScene: BaseScene {
    
    var _page : Int = 0
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.7,green:0.3,blue:0.2,alpha:1.0)
        _page = CommonData.getDataByInt("skill_page")
        setBaseSetting()
        
        let point_y1 = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        
        if _page == 1 {
            setSkill(point_y1,  name: "warrior")
            setSkill(point_y2,  name: "wizard")
            setSkill(point_y3,  name: "priest")
            setSkill(point_y4,  name: "thief")
        } else {
            setSkill(point_y1,   name: "break_block")
            setSkill(point_y2,   name: "zombi")
            setSkill(point_y3,   name: "blood")
        }

        if _page != 2 {
            setNextButton()
        }
        if _page != 1 {
            setBackPageButton()
        }
        setBackButton()
    }

    func setSkill(point_y : CGFloat, name : String){
        let point = CGPointMake(CGRectGetMidX(self.frame), point_y)
        var label : SKLabelNode = SKLabelNode(fontNamed: CommonConst.font_regular)
        if(CommonData.getDataByInt("skill_\(name)") == 1) {
            label.text = SkillSetting.getName(name)
        } else {
            label.text = "???"
        }
        label.fontSize = CGFloat(CommonConst.font_size_normal)
        label.position = CGPointMake(CGRectGetMidX(self.frame), point_y)
        self.addChild(label)
        
        if(CommonData.getDataByInt("skill_\(name)") == 1) {
            var hatena = SKSpriteNode(imageNamed: "hatena.gif")
            hatena.name = "hatena_\(name)"
            hatena.position = CGPointMake(point.x + CGFloat(label.frame.width/2) + 30, point_y + 10)
            self.addChild(hatena)
        }
    }
    
    func setBackButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame) - 50, y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.textBlankHeight*2))
        let startButton: SKSpriteNode = CommonUI.normalButton("戻る", name: "back", point: point)
        self.addChild(startButton)
    }
    
    func setNextButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame) - 50, y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.textBlankHeight*6))
        let startButton: SKSpriteNode = CommonUI.normalButton("次のページ", name: "next", point: point)
        self.addChild(startButton)
    }
    
    func setBackPageButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame) - 50, y:CGRectGetMinY(self.frame) + CGFloat(CommonConst.textBlankHeight*4))
        let startButton: SKSpriteNode = CommonUI.normalButton("前のページ", name: "back_page", point: point)
        self.addChild(startButton)
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goBack()
        } else if name == "back_page" {
            goBackPage()
        } else if name == "next" {
            goNext()
        } else {
            var skill_name : String = ""
            if name == "hatena_warrior" {
                skill_name = "warrior"
            } else if name == "hatena_wizard" {
                skill_name = "wizard"
            } else if name == "hatena_priest" {
                skill_name = "priest"
            } else if name == "hatena_thief" {
                skill_name = "thief"
            } else if name == "hatena_break_block" {
                skill_name = "break_block"
            } else if name == "hatena_blood" {
                skill_name = "blood"
            } else if name == "hatena_zombi" {
                skill_name = "zombi"
            }
            explainMessage(SkillSetting.getName(skill_name), skill_explain: SkillSetting.getExplain(skill_name))
        }
    }
    
    func explainMessage(skill_name: String, skill_explain: String){
        let alert = CommonUI.normalAlert("スキル[\(skill_name)]", message: skill_explain, okMessage: "ふむふむ")
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    // 次のページへ
    func goNext(){
        CommonData.setData("skill_page", value: _page+1)
        let secondScene = SkillScene(size: self.frame.size)
        let tr = SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    // 戻る
    func goBack(){
        let secondScene = StatusScene(size: self.frame.size)
        let tr = SKTransition.crossFadeWithDuration(0.5)
        changeScene(secondScene, tr: tr)
    }

    // 戻る
    func goBackPage(){
        CommonData.setData("skill_page", value: _page-1)
        let secondScene = SkillScene(size: self.frame.size)
        let tr = SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
}

