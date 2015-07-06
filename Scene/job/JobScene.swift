// 転職屋
import SpriteKit

class JobScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)

        setHeader()
        setMoney()
        setExplainText()
        setWarriorButton()
        setWizardlyButton()
        setPriestButton()
        setThiefButton()
        setBackButton("そろそろ帰るぜ")
    }

    func setExplainText(){
        var explainLabel = SKLabelNode(fontNamed: CommonConst.font_regular)
        explainLabel.text = "今すぐに転職だ！"
        explainLabel.fontSize = CGFloat(CommonConst.font_size_normal)
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight))
        explainLabel.position = point
        self.addChild(explainLabel)
    }
    
    // 「戦士」ボタンを設置
    func setWarriorButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(  CommonConst.headerHeight + CommonConst.textBlankHeight*3))
        let startButton: SKSpriteNode = CommonUI.normalButton("戦士", name: "warrior", point: point)
        self.addChild(startButton)
    }
    
    //「魔法使い」ボタンを設置
    func setWizardlyButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*5))
        let startButton: SKSpriteNode = CommonUI.normalButton("魔法使い", name: "wizardly", point: point)
        self.addChild(startButton)
    }

    //「僧侶」ボタンを設置
    func setPriestButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*7))
        let startButton: SKSpriteNode = CommonUI.normalButton("僧侶", name: "priest", point: point)
        self.addChild(startButton)
    }

    //「盗賊」ボタンを設置
    func setThiefButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*9))
        let startButton: SKSpriteNode = CommonUI.normalButton("盗賊", name: "thief", point: point)
        self.addChild(startButton)
    }

    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "warrior" {
                goJobWarriorScene()
            } else if touchedNode.name == "wizardly" {
                goJobWizardScene()
            } else if touchedNode.name == "priest" {
                goJobPriestScene()
            } else if touchedNode.name == "thief" {
                goJobThiefScene()
            } else if touchedNode.name == "back" {
                goShopScene()
            }
        }
    }
    
    // 街画面へ戻る
    func goShopScene(){
        saveMoney()
        let skView = self.view! as SKView
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Right, duration: 0.5)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    func goJobWarriorScene(){
        let secondScene = JobWarriorScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobWizardScene(){
        let secondScene = JobWizardScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobPriestScene(){
        let secondScene = JobPriestScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    func goJobThiefScene(){
        let secondScene = JobThiefScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }

    override func update(currentTime: CFTimeInterval) {
    }
}

