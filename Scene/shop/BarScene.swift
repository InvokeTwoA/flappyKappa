// 酒場の画面
import SpriteKit
class BarScene: BaseScene {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.0,green:0.5,blue:1.0,alpha:1.0)
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*2)
        
        setButton("酔っぱらい冒険者", key_name: "yoi",   point_y: point_y1)
        setButton("謎の男",         key_name: "zombi", point_y: point_y2)
        setButton("親切なペイトン",   key_name: "sinsetu", point_y: point_y3)
        setButton("りんご売りの少女",  key_name: "ringo", point_y: point_y4)
        setCenterButton("他の酒場で二次会だ！", key_name: "bar2", point_y: point_y5)
        setBackButton("あばよ！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "yoi" {
            talkYoi()
        } else if name == "zombi" {
            talkZombi()
        } else if name == "sinsetu" {
            talkSinsetu()
        } else if name == "ringo" {
            talkRingo()
        } else if name == "bar2" {
            goBar2Scene()
        } else if name == "back" {
            goShopScene()
        }
    }
    
    func talkYoi(){
        // Style Alert
        let alert: UIAlertController = UIAlertController(title:"こう見えて俺も昔は名の知れた戦士だったんだ",
            message: "なんでも聞いてくれ",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let q1Action: UIAlertAction = UIAlertAction(title: "操作方法について",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("操作方法", text: "タップするとその場でジャンプ。\nまた、タップした位置に物理攻撃\n\n横にスワイプすると、その方向に動くぜ。\n（横に動く速さは敏捷依存だ）\n\n8回タップする毎に魔法攻撃のファイアボールが発動する。焼き尽くせー！", ok_text: "サンキュー")
        })
        
        let q2Action: UIAlertAction = UIAlertAction(title: "物理攻撃のコツは？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("物理攻撃について", text: "力が高いほど大きなダメージを与えられるぜ。\n物理攻撃はブレ幅が大きいのと、相手の防御力を越えないと１しかダメージを与えられないのが難点だ。\n\nカッパから遠くをタップするほど武器の攻撃スピードが早くなる。\nさらに職業が戦士だとスピード２倍だ", ok_text: "サンキュー")
        })
        let q4Action: UIAlertAction = UIAlertAction(title: "ステージの難易度は？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("難易度について", text: "ノーマル、ハード、カッパ級が選べる。\nそれぞれ敵のHPと攻撃力が２倍、３倍になるが得られるゴールドも２倍、３倍になる。\n\nまた、レア報酬もノーマルだと15%で入手だが、ハードだと30%、カッパ級だと45%になる。\n\n盗賊ならさらに２倍だ。", ok_text: "サンキュー")
        })

        let q5Action: UIAlertAction = UIAlertAction(title: "死ぬとどうなるの？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("死ついて", text: "死ねば全ての金を失い、レベルも１になるだろう。\n\nでも手に入れた武器や、発展した街の施設はなくならない。\n\n死を繰り返すことにより、少しずつ子孫は何かを引き継ぎ強くなっていく。\n\nこの世に無駄な命なんてないという事さ。", ok_text: "サンキュー")
        })
        let q6Action: UIAlertAction = UIAlertAction(title: "街の発展？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("街の発展ついて", text: "新しい勇者が来た時の、能力の初期値が上がるぜ。たとえば武器屋の施設のレベルを3にすれば、今後現れる勇者は力の初期値が+3される。\n\n村の発展には1000Gと高いが、やる価値ありだ。\n\n武器屋→力\nプロレス屋→体力\n学校→知恵\n病院→精神\n雀荘→幸運", ok_text: "サンキュー")
        })
        
        let q7Action: UIAlertAction = UIAlertAction(title: "レベルアップ？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("レベルアップについて", text: "「人生を見直す」画面でゴールドを払えばレベルアップできるぜ。\n\n必要金額はレベルが高いほど高くなるので注意だ。\n\nステータスの成長率は今ついてる職業によって変わるので、色々ろ試してみると良いぜ。\n\n※転職は無料でできるのでジャンジャンしましょう", ok_text: "サンキュー")
        })

        let q8Action: UIAlertAction = UIAlertAction(title: "ビルゲンワースとは？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("ビルゲンワースとは", text: "そんなもの知らん", ok_text: "ですよね")
        })
        

        let cancelAction: UIAlertAction = UIAlertAction(title: "聞くことはない",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        
        alert.addAction(q1Action)
        alert.addAction(q2Action)
        alert.addAction(q4Action)
        alert.addAction(q5Action)
        alert.addAction(q6Action)
        alert.addAction(q7Action)
        alert.addAction(q8Action)
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
                (action:UIAlertAction) -> Void in
                CommonData.blood_plus()
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "関わらないでおこう。",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        alert.addAction(buyAction)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }

    
    func talkSinsetu(){
        if _day < 10 {
            showAlert("親切なペイトン", text: "あなたの冒険日数は\(_day)ですか。\n\n今のあなたには、まだ私のアドバイスは早いですね……ふふふ。", ok_text: "あ、そう")
            return
        }
        
        let alert: UIAlertController = UIAlertController(title:"親切なペイトン",
            message: "なんでも教えてあげましょう……ふふふ。",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        let q1Action: UIAlertAction = UIAlertAction(title: "敵の攻撃が避けられない",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("敵の攻撃が避けられない", text: "一部の敵は出現時にあなたの位置を記録してそこを目指して移動します。\nなのでジッとしていては確実に襲われるので適度に動きましょう。\n\nシスターやガイコツ、ミイラは倒さなければ画面から消えないので、増える前に積極的に倒すのが吉です。\n逆に言えば他のモンスターは無視しても構わないのです。", ok_text: "サンキュー")
        })
        
        let q2Action: UIAlertAction = UIAlertAction(title: "上級職って？",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("上級職について", text: "ある特定の条件を満たせば上級職になれます。\n\n例えばあるモノを装備したり、通り名が特定の状態の時に転職屋に行くと良いですよ。", ok_text: "サンキュー")
        })
        
        let q3Action: UIAlertAction = UIAlertAction(title: "お金を貯めたい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("お金を貯め方", text: "たまには街に出て働いてみるのもアリですよ。\n\nお金を貰える額は5回なら50ゴールド。10回なら200ゴールドとどんどん増えていきます。", ok_text: "サンキュー")
        })
        
        let q4Action: UIAlertAction = UIAlertAction(title: "もっとお金を貯めたい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("お金の貯め方　その２", text: "幸運が高いなら雀荘にでも通ってはいかがですか？\n\n仮に負けても、そのままギャンブラーに転職すれば一儲けできるかもしれません。", ok_text: "サンキュー")
        })
        
        let q5Action: UIAlertAction = UIAlertAction(title: "とにかくお金を貯めたい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("お金の貯め方　その３", text: "寄り道ステージは遊んでますか？\n\nある特殊な条件を満たせば金のスライムが稀に出現するらしいです。\n\n運良く倒せれば一攫千金も夢ではないとか……", ok_text: "サンキュー")
        })
        let q6Action: UIAlertAction = UIAlertAction(title: "たまに強い攻撃が出るんだが",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("必殺について", text: "幸運が高いと物理攻撃がクリティカルヒットになりやすいようです。\n\n幸運は他にもいろいろな効果があるので上げて損ないですよ。", ok_text: "サンキュー")
        })
        
        let q8Action: UIAlertAction = UIAlertAction(title: "可愛い子を紹介してくれ",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction) -> Void in
                self.showAlert("紹介したいのは山々ですが……", text: "私も最近合コンに行ってないんですよ。", ok_text: "お互い頑張ろう")
        })
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "聞くことはない",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction) -> Void in
                self.changeNickname("冷やかし", percent: 50)
        })
        
        alert.addAction(q1Action)
        alert.addAction(q2Action)
        alert.addAction(q3Action)
        alert.addAction(q4Action)
        alert.addAction(q5Action)
        alert.addAction(q6Action)
        alert.addAction(q8Action)
        alert.addAction(cancelAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func talkRingo(){
        showAlert("焼肉売りの少女", text: "戦闘中、たまに出てくる焼肉を食べるとHPが回復します。\n（回復量は精神に依存）\n\nボスを倒した後はどんなにHPが減っても死なないのでゆっくりとコイン集めをしてください。", ok_text: "なるほどね")
    }

    func goBar2Scene(){
        let secondScene = Bar2Scene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
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

