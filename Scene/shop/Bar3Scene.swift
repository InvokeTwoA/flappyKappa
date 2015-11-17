// 酒場の画面
import SpriteKit
class Bar3Scene: BaseScene {
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)

        setCenterButton("生意気な少年",   key_name: "shounen", point_y: point_y1)
        if _day > 5 {
            setCenterButton("おや、次元の狭間を発見", key_name: "jigen", point_y: point_y2)
        }
        setCenterButton("命名神",   key_name: "gimei", point_y: point_y3)
        
        setBackButton("あばよ！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "gimei" {
            talkGimei()
        } else if name == "shounen" {
            talkShounen()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    func talkGimei(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"お主の名前を変えてやろう",
            message: "かっこいい名前を入力するのじゃ（４文字以内）",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "これが俺の名だ",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                // 入力したテキストを保存
                let textField = alert.textFields![0]
                
                var str : String = textField.text!
                if(str == ""){
                    self.setDefaultName()
                } else if str.utf16.count > 4 {
                    str = (str as NSString).substringToIndex(4)
                    CommonData.setData("name", value: str)
                    self.changeName(str)
                } else {
                    CommonData.setData("name", value: str)
                    self.changeName(str)
                }
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "遠慮しときます",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction) -> Void in
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
    func changeTextField(sender: NSNotification) {
        /*
        var textField = sender.object as! UITextField
        //UIAlertAction * createAction = alertController.actions.lastObject;
        var InputStr = textField.text
        if count("\(InputStr)") <= 4 {
        textField.enabled = true
        } else {
        textField.enabled = false
        }
        */
    }

    func changeName(name :String){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"名前変更完了じゃ！",
            message: "さあ行けぇ、\(name)　魔王を倒すのじゃ！！",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "はーい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.reloadScene()
        })
        alert.addAction(yesAction)
        // UIAlertControllerにtextFieldを追加
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func setDefaultName(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"空気を読んでツンデレという名前にしてあげよう。",
            message: "さあ行けぇ、ツンデレ！　魔王を倒すのじゃ！！",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "はーい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                CommonData.setData("name", value: "ツンデレ")
                self.reloadScene()
        })
        alert.addAction(yesAction)
        // UIAlertControllerにtextFieldを追加
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reloadScene(){
        print("a")
        let secondScene = Bar3Scene(size: self.frame.size)
        let tr = SKTransition.crossFadeWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    
    func talkShounen(){
        if (CommonData.getDataByInt("story") == 1)  {
            showAlert("カッパが勇者？", text:"そんなの無理に決まってるよ", ok_text: "笑いたければ笑うが良い")
        } else {
            showAlert("勇者のカッパさんだ！", text:"サインしてください！　おなしゃす！", ok_text: "こらこら、よさないか")
        }
    }
        
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goGameScene(){
        let secondScene = GameScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    }
    
    func goJigen() {
        let secondScene = JigenScene(size: self.frame.size)
        let tr = SKTransition.fadeWithColor(UIColor.grayColor(), duration: 3)
        changeScene(secondScene, tr: tr)
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
    }
}

