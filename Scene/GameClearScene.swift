//ゲームクリア画面
import SpriteKit
import GameKit
import AVFoundation

class GameClearScene: BaseScene, AVAudioPlayerDelegate {
    
    var _stage = CommonData.getDataByString("stage_name")
    var _name = CommonData.getDataByString("name")
    
    var _bgm_off : Bool          = CommonData.getDataByBool("bgm_off")
    var _audioPlayer:AVAudioPlayer!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
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
        
        if _stage == "maou" {
            changeNickname("真の", percent: 77)
            setCenterText("こうして世界に平和は訪れた", key_name: "text1", point_y: y1)
            setCenterText("君の活躍は伝説として", key_name: "text2", point_y: y2)
            setCenterText("カッパサーガとして語り継がれていく", key_name: "text3", point_y: y3)
            
            setCenterText("一人で魔王を倒すなんて", key_name: "text3", point_y: y4)
            setCenterText("中々できる事じゃないよ。", key_name: "text4", point_y: y5)

            setBackButton("こらこら、よさないか")
        } else if _stage == "mugen" {
            let nickname = CommonUI.displayName()
            setCenterText("さすが\(nickname)", key_name: "text1", point_y: y1)
            setCenterText("カッパでも勇者になれる……", key_name: "text2", point_y: y2)
            setCenterText("それを君は見事に証明したのだ！", key_name: "text3", point_y: y3)
            setCenterText("しかしこの世に光と闇がある限り", key_name: "text4", point_y: y4)
            setCenterText("やがて新たな悪も生まれるだろう", key_name: "text5", point_y: y5)
            setCenterText("「俺たちの戦いはこれからだぁ！」", key_name: "text6", point_y: y6)
            changeNickname("伝説の", percent: 100)
            setBackButton("次回作にご期待ください")
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
            case "odon":
                setCenterText("紹介状を手に入れた", key_name: "text6", point_y: y6)
                CommonData.setData("shoukai", value: 1)
            case "seizon":
                setCenterText("たぬきブリンガーを手に入れた", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_bringer", value: 1)
            case "white":
                setCenterText("魔王城の鍵を手に入れた", key_name: "text6", point_y: y6)
                CommonData.setData("mao_key", value: 1)
            case "kettou":
                setCenterText("カッパソードを手に入れた", key_name: "text6", point_y: y6)
                CommonData.setData("weapon_kappa_sword", value: 1)
            default:
                print("しかし空っぽだった", terminator: "")
            }
        }
        prepareBGM("clear")
        playBGM()
    }
        
    func prepareBGM(fileName : String){
        let bgm_path = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!)
        var audioError:NSError?
        do {
            _audioPlayer = try AVAudioPlayer(contentsOfURL: bgm_path)
        } catch let error as NSError {
            audioError = error
            _audioPlayer = nil
        }
        if let error = audioError {
            print("Error \(error.localizedDescription)")
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
        
        if _danjon_type == "special" && rnd < 45 {
            return true
        } else if _danjon_type == "hard" && rnd < 30 {
            return true
        } else if rnd < 15 {
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
}
