//ゲームオーバー画面
import SpriteKit
class GameOverScene: BaseScene {
    override func didMoveToView(view: SKView) {
        CommonData.deadStatus()
        CommonData.dayPast()
        setHeader()
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
        setPicture("kappa_suya")
        
        var end_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        end_text.text = "カッパは力尽きてしまった……。"
        end_text.fontSize = 18
        end_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2 + 180))
        self.addChild(end_text)

        changeNickname("ゾンビ", percent: 3)
        changeNickname("崖っぷち", percent: 3)
        changeNickname("悲しい", percent: 3)
        changeNickname("情けない", percent: 3)
        changeNickname("ヘタレ", percent: 3)
        changeNickname("文無し", percent: 3)
        setBackButton()
    }
    
    func setBackButton() {
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 200)
        let startButton: SKSpriteNode = CommonUI.normalButton("がんばリベンジだ！！", name: "back", point: point)
        self.addChild(startButton)
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "back" {
                goTitle()
            }
        }
    }
    
    func goTitle(){
        let nextScene = GameScene(size: self.frame.size)
        let tr = SKTransition.flipHorizontalWithDuration(1)
        changeSceneWithLongDuration(nextScene, tr: tr, duration: 1)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
