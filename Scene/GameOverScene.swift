//ゲームオーバー画面
import SpriteKit
class GameOverScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
    
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: "kappa_suya")
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 200)
        kappa.position = point
        self.addChild(kappa)
        
        var end_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        end_text.text = "カッパは力尽きてしまった……。"
        end_text.fontSize = 18
        end_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 0)
        self.addChild(end_text)
        
        changeNickname("崖っぷち", percent: 3)
        changeNickname("悲しい", percent: 3)
        setBackButton()
    }
    
    //タイトルに戻るボタンを設置
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
        let skView = self.view! as SKView
        nextScene.scaleMode = SKSceneScaleMode.AspectFill
        let tr = SKTransition.flipHorizontalWithDuration(1)
        skView.presentScene(nextScene, transition: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
