//ゲームクリア画面
import SpriteKit
import GameKit

class GameClearScene: BaseScene, GKGameCenterControllerDelegate {
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor(red:0.4,green:0.7,blue:0.9,alpha:1.0)
/*
        var kappa : SKSpriteNode = SKSpriteNode(imageNamed: "kappa_suya.png")
        let point : CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 200)
        kappa.position = point
        self.addChild(kappa)
*/
        CommonData.dayPast()
        setBaseSetting()
        
        let y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight)
        let y2 = y1 - CGFloat(CommonConst.textBlankHeight)
        let y3 = y2 - CGFloat(CommonConst.textBlankHeight)
        
        var end_text = SKLabelNode(fontNamed: CommonConst.font_regular)
        end_text.text = "カッパは居酒屋にたどり着いた！"
        end_text.fontSize = 18
        end_text.position = CGPoint(x:CGRectGetMidX(self.frame), y: y1)
        self.addChild(end_text)

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
        
        
        // setButton("ハイスコアを見る", key_name: "high_score", point_y: y3)
        setBackButton("今夜は焼肉だー！")
    }
    
    // タッチイベント
    override func checkTochEvent(name: String) {
        if name == "back" {
            goAdventure()
        } else if name == "high_score" {
            showLeaderboardScore()
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
