//ゲームクリア画面
import SpriteKit
import GameKit
import AVFoundation

class GameClearScene: BaseScene, GKGameCenterControllerDelegate, AVAudioPlayerDelegate {
    
    var _stage = CommonData.getDataByString("stage_name")
    var _name = CommonData.getDataByString("name")
    
    var _bgm_off : Bool          = CommonData.getDataByBool("bgm_off")
    var _audioPlayer:AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
/*
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: "kappa_suya.png")
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 200)
        kappa.position = point
        self.addChild(kappa)
*/
        if _job == "勝負師" {
            CommonData.plus("gold", value: _day)
        }
                
        CommonData.dayPast()
        setBaseSetting()
        
        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight)
        let y4 = y3 - CGFloat(CommonConst.textBlankHeight*2)
        let y5 = y4 - CGFloat(CommonConst.textBlankHeight)
        let y6 = y5 - CGFloat(CommonConst.textBlankHeight)
        
        if _stage == "mugen" {
            changeNickname("伝説の", percent: 100)
        }
        
        
        if _stage == "maou" {
            changeNickname("真の", percent: 77)
            setCenterText("こうして世界に平和は訪れた", key_name: "text1", point_y: y1)
            setCenterText("君の活躍は伝説として", key_name: "text2", point_y: y2)
            setCenterText("カッパサーガとして語り継がれていく", key_name: "text3", point_y: y3)
            
            setCenterText("一人で魔王を倒すなんて", key_name: "text3", point_y: y4)
            setCenterText("中々できる事じゃないよ。", key_name: "text4", point_y: y5)

            setBackButton("こらこら、よさないか")
        } else {
            setCenterText("君は冒険の目的を達成した。", key_name: "text1", point_y: y1)
            setCenterText("しかし魔王がいる限り戦いは続く", key_name: "text2", point_y: y2)
            setCenterText("戦え、\(_name)！", key_name: "text3", point_y: y3)
            setCenterText("負けるな、\(_name)！", key_name: "text4", point_y: y4)
            setBackButton("今夜は焼肉だー！")
        }
        if checkTreasure() {
            setCenterText("君は幸運にも宝を見つけた。", key_name: "text5", point_y: y5)
            
            switch _stage {
            case "slime":
                setCenterText("オレ杖を手に入れたぞ。", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_oretue", value: 1)
            case "tanuki":
                setCenterText("財宝1000Gを手に入れたぜ。", key_name: "text6", point_y: y6)
                CommonData.plus("gold", value: 1000)
            case "golem":
                setCenterText("カッパソウルを手に入れたよ。", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_soul", value: 1)
            case "dojo_g":
                setCenterText("重力子放射線射出装置を手に入れたぜ。", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_juryoku", value: 1)
            case "noukin":
                setCenterText("HPが３あがった", key_name: "text6", point_y: y6)
                CommonData.plus("hp",      value: 3)
            case "taiman":
                setCenterText("知恵と信仰の成長力があがった", key_name: "text6", point_y: y6)
                CommonData.plus("int_up",      value: 1)
                CommonData.plus("pri_up",      value: 1)
            case "maho":
                setCenterText("LVが1になった", key_name: "text6", point_y: y6)
                CommonData.setData("lv", value: 1)
            case "kabe":
                setCenterText("聖シャインの剣を手に入れた", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_shine", value: 1)
            default:
                print("報酬が用意されてません")
            }
        }
/*
        var score_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        let score = CommonData.getDataByInt("stage_score")
        score_text.text = "スコア: \(score)"
        score_text.fontSize = 18
        score_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:y2)
        self.addChild(score_text)
        //self.reportScore(score)

        var get_gold : Int = 0

        get_gold += score
        CommonData.plus("gold", value: get_gold)

        var gold_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        score_text.text = "スコア: \(get_gold)"
        score_text.fontSize = 18
        score_text.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - CGFloat( CommonConst.textBlankHeight*4))
        self.addChild(gold_text)
*/
        // setButton("ハイスコアを見る", key_name: "high_score", point_y: y3)
        
        prepareBGM("clear")
        playBGM()
    }
        
    func prepareBGM(fileName : String){
        let bgm_path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        var audioError:NSError?
        _audioPlayer = AVAudioPlayer(contentsOfURL: bgm_path, error:&audioError)
        if let error = audioError {
            println("Error \(error.localizedDescription)")
        }
        _audioPlayer.delegate = self
        _audioPlayer.prepareToPlay()
    }
    
    func playBGM(){
        if _bgm_off {
            return
        }
        _audioPlayer.numberOfLoops = -1;
        if ( !_audioPlayer.playing ){
            _audioPlayer.play()
        }
    }
    
    func stopBGM(){
        if ( _audioPlayer.playing ){
            _audioPlayer.stop()
        }
    }
    
    
    override func saveMoney() {
        return
    }
    
    func checkTreasure() -> Bool{
        if _stage == "maou" || _stage == "mugen"{
            return false
        }

        var rnd = CommonUtil.rnd(100)
        if CommonData.getDataByString("job") == "盗賊" {
            rnd = CommonUtil.rnd(50)
        }
        
        if _danjon_type == "special" && rnd < 20 {
            return true
        } else if _danjon_type == "hard" && rnd < 10 {
            return true
        } else if rnd < 5 {
            return true
        }
        return false
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            if _stage == "maou" {
                goEnding()
            } else {
                goAdventure()
            }
        } else if name == "high_score" {
            showLeaderboardScore()
        }
    }

    // 冒険へ
    func goAdventure(){
        stopBGM()
        let secondScene = MapScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    }
    
    func goEnding(){
        stopBGM()
        let secondScene = EndingScene(size: self.frame.size)
        let tr = SKTransition.flipVerticalWithDuration(1)
        changeScene(secondScene, tr: tr)
    
    }
    
    override func update(currentTime: CFTimeInterval) {
    }
    
    
    // GameCenterにハイスコア送信
    // 廃止
    func reportScore(score : Int) {
        return;
        /*
        // スコアを送信するGKScoreクラスを生成
        let stage_name = CommonData.getDataByString("stage_name")
        let stage = "\(stage_name)_score"
        
        print("send score \(score). to: \(stage)")
        
        let myScore = GKScore(leaderboardIdentifier: stage)

        // スコアを設定
        myScore.value = Int64(score)
        // スコアを送信
        GKScore.reportScores([myScore], withCompletionHandler: { (error) -> Void in
            if error != nil {
                print("game center send error. \(error.code).\(error.description)")
            } else {
                print("game center send success")
            }
        })
        */
    }

    // FIXME
    func reportAchievement() {
        // Achievementを送信するGKAchievementクラスを生成
        let myAchievement = GKAchievement(identifier: "SwiftGameCenter.Score10")
        // 達成率を設定（0〜100%）
        myAchievement.percentComplete = 100
        // Achievementを送信
        GKAchievement.reportAchievements([myAchievement], withCompletionHandler:
            { (error) -> Void in
                if error != nil {
                    print(error.code)
                }
        })
    }
    
    /*
    *  GKScoreにてスコアが送信されたデータスコアをLeaderboardで確認する
    */
    func showLeaderboardScore() {
        
        let stage_name = CommonData.getDataByString("stage_name")
        let leaderboardIdentifier = "\(stage_name)_score"
        
        var localPlayer = GKLocalPlayer()
        localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifier : String!, error : NSError!) -> Void in
            if error != nil {
                print("game center show error. \(error.description)")
            } else {
                let gameCenterController:GKGameCenterViewController = GKGameCenterViewController()
                gameCenterController.gameCenterDelegate = self
                gameCenterController.viewState = GKGameCenterViewControllerState.Leaderboards

                gameCenterController.leaderboardIdentifier = leaderboardIdentifier
                self.view?.window?.rootViewController?.presentViewController(gameCenterController, animated: true, completion: nil)
            }
        })
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        //code to dismiss your gameCenterViewController
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil);
    }

}
