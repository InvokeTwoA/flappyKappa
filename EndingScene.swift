// エンディング表示クラス
// ここに関しては静的な画面なので、BaseSceneを継承しない

import SpriteKit

class EndingScene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        CommonData.setData("story", value: 2)
        self.backgroundColor = UIColor(red:0.1,green:0.1,blue:0.1,alpha:0.1)
        setBaseSetting()
        
        // キャラ設置
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMaxY(self.frame) - 50)
        setGhostDemo(point)
        setFighter()
        setWitch()
        setSister()
        setKnight()
        setSkelton()
        setMaou()
        
        setTitleLabel()
        setStartButton()
    }
    
    override func setMoney(){
        return
    }
    
    override func setHeader(){
        return
    }
    
    func setFighter(){
        var chara = FighterNode.makeDemo()
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
    
    func setSister(){
        var chara = SisterNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMidY(self.frame) +   140)
        chara.position = point
        self.addChild(chara)
    }
    
    
    func setKnight(){
        var chara = KnightNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 30, y:CGRectGetMinY(self.frame) +   140)
        chara.position = point
        self.addChild(chara)
    }
    
    func setSkelton(){
        var chara = SkeltonNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:CGRectGetMinY(self.frame) + 100)
        chara.position = point
        self.addChild(chara)
    }
    
    
    func setMaou(){
        var chara = MaoNode.makeDemo()
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 40, y:CGRectGetMinY(self.frame) + 50)
        chara.position = point
        self.addChild(chara)
    }
    
    // 炎画像を出す
    func setFireButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame) + 50, y: 50)
        let fire = FireNode.make(point)
        self.addChild(fire)
    }
    
    // タイトルラベルを設置
    func setTitleLabel() {
        let myLabel = SKLabelNode(fontNamed:CommonConst.font_bold)
        myLabel.text = "THANK YOU FOR PLAYING";
        myLabel.fontSize = 28;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame) - 100);
        myLabel.color = UIColor.blackColor()
        self.addChild(myLabel)
    }
    
    // スタートボタンを設置
    func setStartButton(){
        let point : CGPoint = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + 100)
        let startLabel = CommonUI.normalButton("再び冒険へ", name: "start", point: point)
        self.addChild(startLabel)
    }
    
    override func checkTochEvent(name: String) {
        if name == "start" {
            start()
        } else if name == "break" {
            worldBreak()
        } else if name == "setting" {
            goSettingScene()
        } else {
            kappaJump()
        }
    }
    
    func start() {
        // もしデータが存在しなかったら、全ての値を初期化
        if (CommonData.getDataByInt("story") == 0)  {
            CommonData.initData()
            inputName()
            
            
        } else {
            goGameScene()
        }
    }
    
    
    func changeTextField(sender: NSNotification) {
        var textField = sender.object as! UITextField
        var InputStr = textField.text
        if count("\(InputStr)") <= 5 {
            textField.enabled = true
        } else {
            textField.enabled = false
        }
    }
    
    func inputName(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"カッパサーガの世界へようこそ",
            message: "名前を入力してください",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "これが俺の名だ",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                // 入力したテキストを保存
                let textField = alert.textFields![0] as! UITextField
                CommonData.setData("name", value: textField.text)
                CommonData.setData("story", value: 1)
                self.goGameScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "名乗りたくない",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.setDefaultName()
        })
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        // UIAlertControllerにtextFieldを追加
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField!) -> Void in
            // NotificationCenterを生成.
            let myNotificationCenter = NSNotificationCenter.defaultCenter()
            // textFieldに変更があればchangeTextFieldメソッドに通知.
            myNotificationCenter.addObserver(self, selector: "changeTextField:", name: UITextFieldTextDidChangeNotification, object: nil)
            
        }
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setDefaultName(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"空気を読んでイケメンという名前にしてあげました。",
            message: "勇者イケメンとなり、魔王を倒してください",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "わかったぜ",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.setData("name", value: "イケメン")
                CommonData.setData("story", value: 1)
                self.goGameScene()
        })
        alert.addAction(yesAction)
        // UIAlertControllerにtextFieldを追加
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func goGameScene(){
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
