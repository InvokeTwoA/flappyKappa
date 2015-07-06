// タイトル表示クラス
// ここに関しては静的な画面なので、BaseSceneを継承しない

import SpriteKit

class TitleScene: BaseScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.2,green:0.6,blue:0.3,alpha:1.0)
        
        setTitleLabel()
        setStartButton()
        setBreakButton()
        setSasuoniButton()
        setFireButton()
    }

    // タイトルラベルを設置
    func setTitleLabel() {
        let myLabel = SKLabelNode(fontNamed:CommonConst.font_bold)
        myLabel.text = "Flappy Kappa";
        myLabel.fontSize = 32;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 100);
        self.addChild(myLabel)
    }
    
    // スタートボタンを設置
    func setStartButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 100)
        let startLabel = CommonUI.normalButton("はじめる", name: "start", point: point)
        self.addChild(startLabel)
    }

    // 世界破壊ボタンを設置
    func setBreakButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 0)
        let startLabel = CommonUI.normalButton("地球を破壊する", name: "break", point: point)
        self.addChild(startLabel)
    }
    
    // 最強ボタンを設置
    func setSasuoniButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 100)
        let startLabel = CommonUI.normalButton("最強モード", name: "sasuoni", point: point)
        self.addChild(startLabel)
    }
    
    // 炎画像を出す
    func setFireButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame) - 100, y: 100)
        let fire = FireNode.make(point)
        self.addChild(fire)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        let location = touch!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        if (touchedNode.name != nil) {
            if touchedNode.name == "start" {
                goGameScene()
            } else if touchedNode.name == "break" {
                worldBreak()
            } else if touchedNode.name == "sasuoni" {
                sasuoni()
            }
        }
    }

    // ゲーム画面へ
    func goGameScene() {
        // もしデータが存在しなかったら、全ての値を初期化
        if (CommonData.getData("story") == nil)  {
            CommonData.initData()
        }
    
        CommonData.setData("adTime", value: 2)
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.doorwayWithDuration(2)
        let skView = self.view! as SKView
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(secondScene, transition: tr)
    }
    
    // 地球破壊ボタン
    func worldBreak(){
        let alert : UIAlertController = CommonUI.normalAlert("無理っす", message: "(´；ω；｀)", okMessage: "仕方ないな")        
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        CommonData.initData()        
    }
    
    func sasuoni(){
        CommonData.getAllSkill()
    }
        
    override func update(currentTime: CFTimeInterval) {
    }
    
}
