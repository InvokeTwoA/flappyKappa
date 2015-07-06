//ゲームクリア画面
import SpriteKit
class GameClearScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
/*
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: "kappa_suya.png")
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 200)
        kappa.position = point
        self.addChild(kappa)
*/
        setHeader()
        setMoney()
        
        var end_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        end_text.text = "カッパは居酒屋にたどり着いた！"
        end_text.fontSize = 18
        end_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 0)
        self.addChild(end_text)

        var score_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        let score = CommonData.getDataByInt("stage_score")
        score_text.text = "スコア: \(score)"
        score_text.fontSize = 18
        score_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - CGFloat( CommonConst.textBlankHeight*2))
        self.addChild(score_text)
        
        var get_gold : Int = 0

        get_gold += score
        CommonData.plus("gold", value: get_gold)

        var gold_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        score_text.text = "獲得ゴールド: \(get_gold)"
        score_text.fontSize = 18
        score_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - CGFloat( CommonConst.textBlankHeight*4))
        self.addChild(gold_text)
        
        setBackButton("今夜は焼肉だー！")
    }
    
    // タッチイベント
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "back" {
                goAdventure()
            }
        }
    }

    // 冒険へ
    func goAdventure(){
        let secondScene = MapScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
}
