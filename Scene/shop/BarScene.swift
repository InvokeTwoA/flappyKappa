// 酒場の画面
import SpriteKit
class BarScene: BaseScene {
    
    var _buy_name : String = "ぶひ"
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        
        setButton("酔っぱらい冒険者", key_name: "yoi",   point_y: point_y1)
        setButton("謎の男",         key_name: "zombi", point_y: point_y2)
//        setButton("夜逃げ屋",       key_name: "yonige", point_y: point_y3)
//        setButton("金持ち爺さん",    key_name: "kane", point_y: point_y4)
        setButton("怪しい神父",           key_name: "kami", point_y: point_y5)
        
        setBackButton("あばよ！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "yoi" {
            talkYoi()
        } else if name == "zombi" {
            talkZombi()
        } else if name == "yonige" {
            talkYonige()
        } else if name == "kane" {
            talkKane()
            } else if name == "kami" {
            talkKami()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    func talkYoi(){
        // Style Alert
        let name = WeaponSetting.getName(_buy_name)
        
        let alert: UIAlertController = UIAlertController(title:"こう見えて俺も昔は名の知れた戦士だったんだ",
            message: "なんでも聞いてくれ",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let q1Action: UIAlertAction = UIAlertAction(title: "操作方法について",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("操作方法", text: "タップするとその場でジャンプ。\nまた、タップした位置に物理攻撃\n\n横にスワイプすると、その方向に動くぜ。\n横に動く速さは敏捷依存だ\n\n10回タップする毎に魔法攻撃のファイアボールが発動するぜ。", ok_text: "サンキュー")
        })
        
        let q2Action: UIAlertAction = UIAlertAction(title: "物理攻撃のコツは？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("物理攻撃について", text: "力が高いほど大きなダメージを与えられるぜ。物理攻撃はブレ幅が大きいのと、相手の防御力を越えないと１しかダメージを与えられないのが難点だ。\n\nただ、運が良ければ会心の一撃で相手の防御力無視の大ダメージを与えられるぜ\n\nあと投げる武器はカッパから遠くをタップするほどスピードが早くなる。さらに職業が戦士だとスピード２倍だ", ok_text: "サンキュー")
        })
        let q3Action: UIAlertAction = UIAlertAction(title: "回復は？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("回復について", text: "たまに出てくるリンゴを食べろ。回復量は精神に依存だ。", ok_text: "サンキュー")
        })
    
        let q4Action: UIAlertAction = UIAlertAction(title: "ステージの難易度は？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("難易度について", text: "ノーマル、ハード、カッパ級が選べる。\nそれぞれ敵のHPと攻撃力が２倍、３倍になるが得られるゴールドも２倍、３倍になる。\n\nまた、レア報酬もノーマルだと5%で入手だが、ハードだと10%、カッパ級だと20%になる。\n盗賊ならさらに２倍だ。", ok_text: "サンキュー")
        })

        let q5Action: UIAlertAction = UIAlertAction(title: "死ぬとどうなるの？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("死ついて", text: "死ねば全ての金を失い、レベルも１になる。新しい冒険者に任せる事になるだろう。\n\nでも手に入れた武器や、発展した街の施設はなくならない。\n\nあと子孫というのは親の何かを引き継ぐものらしい。一族の財産は少しずつでも大きくなっていくだろう。\n\nそれに称号付きの冒険者は強いから、運が良ければ有能な冒険者があとを引き継いでくれるかもしれない。", ok_text: "サンキュー")
        })
        let q6Action: UIAlertAction = UIAlertAction(title: "街の発展？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("街の発展ついて", text: "新しい勇者が来た時の、能力の初期値が上がります。たとえば武器屋の施設のレベルを3にすれば、今後現れる勇者は力の初期値が+3されます。\n\n村の発展には1000Gかかる。", ok_text: "サンキュー")
        })
        
        let q7Action: UIAlertAction = UIAlertAction(title: "レベルアップ？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.showAlert("レベルアップについて", text: "「人生を見直す」画面でゴールドを払えばできる。必要金額はレベルが高いほど高くなるので注意だ。ステータスの成長率は今ついてる職業によって変わるので、色々ろ試してみると良い。\n\n職業毎に独自のスキルを持ってる。\n転職は誰でもタダでできる。", ok_text: "サンキュー")
        })


        let cancelAction: UIAlertAction = UIAlertAction(title: "聞くことはない",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        
        alert.addAction(q1Action)
        alert.addAction(q2Action)
                alert.addAction(q3Action)
                alert.addAction(q4Action)
                alert.addAction(q5Action)
                alert.addAction(q6Action)
                alert.addAction(q7Action)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)

    }
    
    func talkZombi(){
        let lv =  CommonData.getDataByInt("lv")
        if(lv < 10){
            showAlert("謎の男", text: "「LVが低い人間は私と話す資格はない……」", ok_text: "お、おう。")
        } else {
            blood_plus()
        }
    }
        
    func blood_plus(){
        let alert: UIAlertController = UIAlertController(title:"謎の男",
            message: "ククク。禁断の力が欲しいか？ \n  代償と引き換えにスキル[吸血]が手に入ります。\n\n代償：体力が1になる\n\nリンゴを食べると２０ダメージ受けるようになる\n\nスキル[吸血]敵を倒す毎に１ライフ回復\n\nこのスキルは死亡するか転職したら忘れてしまいます",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "力が……欲しい！",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.blood_plus()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "関わらないでおこう。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    
    func talkYonige(){
        let alert: UIAlertController = UIAlertController(title:"夜逃げ屋",
            message: "全財産を捨てて一からやり直さないか？ \n\n 所持金が0になり、LVが１になります。全ステータスが半減します。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let yesAction: UIAlertAction = UIAlertAction(title: "一からやり直そう",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("文無し", percent: 20)
                self.changeNickname("フリーダム", percent: 10)
                CommonData.change_yonige_status()
                self.goGameScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "冗談じゃねえ。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("常識", percent: 10)
        })
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func talkKane(){
        showAlert("おお、神よ！", text:"セーブデータを消したいならばタイトル画面で「地球を破壊する」を4回押せば良いのですね", ok_text: "……関わらないでおこう")
    }

    func talkKami(){
        let alert: UIAlertController = UIAlertController(title:"夜逃げ屋",
            message: "全財産を捨てて一からやり直さないか？ \n\n 所持金が0になり、LVが１になります。全ステータスが半減します。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let buyAction: UIAlertAction = UIAlertAction(title: "一からやり直そう",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("文無し", percent: 20)
                self.changeNickname("フリーダム", percent: 10)
                CommonData.change_yonige_status()
                self.goGameScene()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "冗談じゃねえ。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                self.changeNickname("常識", percent: 10)
        })
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
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
    
    override func update(currentTime: CFTimeInterval) {
    }
}

