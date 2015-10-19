// タイトル表示クラス
// ここに関しては静的な画面なので、BaseSceneを継承しない

import SpriteKit

class TitleScene: BaseScene {

    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        // キャラ設置
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMaxY(self.frame) - 50)
        setGhostDemo(point)
        setFighter()
        setWitch()
        
        setTitleLabel()
        setStartButton()
        setBreakButton()
        setSettingButton()
        setFireButton()
    }
    
    override func setMoney(){
        return
    }
    
    override func setHeader(){
        return
    }
    
    func setFighter(){
        var chara = MaoNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMidY(self.frame))
        chara.position = point
        self.addChild(chara)
    }
    
    func setWitch(){
        var chara = WitchNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 40, y:CGRectGetMidY(self.frame) +   70)
        chara.position = point
        self.addChild(chara)
    }

    // タイトルラベルを設置
    func setTitleLabel() {
        let myLabel = SKLabelNode(fontNamed:CommonConst.font_bold)
        myLabel.text = "Kappa Saga";
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
    
    func setSettingButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 100)
        let startLabel = CommonUI.normalButton("せってい", name: "setting", point: point)
        self.addChild(startLabel)
    }
    
    // 炎画像を出す
    func setFireButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame) - 100, y: 100)
        let fire = FireNode.make(point)
        self.addChild(fire)
    }
    
    override func checkTochEvent(name: String) {
        if name == "start" {
            goGameScene()
        } else if name == "break" {
            worldBreak()
        } else if name == "setting" {
            goSettingScene()
        } else {
            kappaJump()
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
    
    // ゲーム画面へ
    func goSettingScene() {
        let secondScene = SettingScene(size: self.frame.size)
        let tr = SKTransition.doorsOpenHorizontalWithDuration(1)
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
    
    override func update(currentTime: CFTimeInterval) {
    }
    
}
