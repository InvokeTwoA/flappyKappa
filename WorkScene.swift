// 街画面
import SpriteKit
class WorkScene: BaseScene {
    var _hit : Int = 0
    var _highScore : Int = CommonData.getDataByInt("work_high_score")
    
    override func didMoveToView(view: SKView) {
        setBaseSetting()
        
        let point_y1 : CGFloat = CGRectGetMaxY(self.frame) - CGFloat(CommonConst.headerHeight + CommonConst.textBlankHeight*2)
        let point_y2 : CGFloat = point_y1 - CGFloat(CommonConst.textBlankHeight*2)
        let point_y3 : CGFloat = point_y2 - CGFloat(CommonConst.textBlankHeight*1)
        let point_y4 : CGFloat = point_y3 - CGFloat(CommonConst.textBlankHeight*1)
        let point_y5 : CGFloat = point_y4 - CGFloat(CommonConst.textBlankHeight*1)
        let point_y6 : CGFloat = point_y5 - CGFloat(CommonConst.textBlankHeight*1)
        let point_y7 : CGFloat = point_y6 - CGFloat(CommonConst.textBlankHeight*1)
        let point_y8 : CGFloat = point_y7 - CGFloat(CommonConst.textBlankHeight*1)
        
        setButton("おつかれさまでしたー", key_name: "teiji", point_y: point_y1)
//        setCenterButton("スライム召喚", key_name: "call", point_y: point_y2)
        let point : CGPoint = CGPoint(x:CGRectGetMaxX(self.frame) - 50, y:point_y3)
        setGhostDemo(point)
        setCenterText("スライムをゴーストに当てるべし", key_name: "buhi", point_y: point_y4)
        setCenterText("当てた数に応じて給料をもらえるぞ", key_name: "buhi", point_y: point_y5)
        setCenterText("疲れたら挨拶をして帰ろう", key_name: "buhi", point_y: point_y6)
        setCenterText("ゴーストに当てた数：\(_hit)", key_name: "hit", point_y: point_y7)
        setCenterText("最高記録：\(_highScore)", key_name: "highscore", point_y: point_y8)
    }
    
    override func checkTochEvent(name: String) {
        if name == "teiji" {
            kaeru()
        } else if name == "call" {
            callSlime()
        }
    }
    
    func callSlime(){
        var slime : SlimeNode? = childNodeWithName("slime") as? SlimeNode
        let rnd = CommonUtil.rnd(2)
        var point_x = CGRectGetMinX(self.frame) + 50
        if(rnd == 0){
            point_x = CGRectGetMaxX(self.frame) - 50
        }
        slime!.position = CGPoint(x:point_x, y:CGRectGetMidY(self.frame))
    }
    
    func kaeru(){
        dayPast()
        
        // Style Alert
        let alert : UIAlertController
        if(_hit < 10){
            alert = UIAlertController(title:"社長「おつかれさん！」",
                message: "\(_hit)回か。給料は\(_hit*_hit*2)だ",
                preferredStyle: UIAlertControllerStyle.Alert
            )
        } else {
            alert = UIAlertController(title:"社長「君こそ次の社長だ！」",
                message: "\(_hit)回、給料は\(_hit*_hit*2)だ。すごい！",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            changeNickname("即戦力の", percent: 50)
        }
        if _hit > _highScore  {
            CommonData.setData("work_high_score", value: _hit)
        }
        
        
        let buyAction: UIAlertAction = UIAlertAction(title: "失礼しまーす",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                CommonData.plus("gold", value: self._hit*self._hit*2)
                self.setMoney()
                self.goShopScene()
        })
        alert.addAction(buyAction)
        self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    func goShopScene(){
        let secondScene = ShopScene(size: self.frame.size)
        let tr = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 0.5)
        changeScene(secondScene, tr: tr)
    
    }
    
    
    override func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 剣の衝突判定
        if (firstBody.categoryBitMask & swordCategory != 0 ) {
            if secondBody.categoryBitMask & worldCategory != 0 {
                firstBody.node?.removeFromParent()
            } else if secondBody.categoryBitMask & blockCategory != 0 {
                makeSpark(firstBody.node?.position)
                firstBody.node?.removeFromParent()
            }
        }
        
        // スライムとゴーストが衝突するとゴールド
        if (firstBody.categoryBitMask & enemyCategory != 0 ) {
            if secondBody.categoryBitMask & blockCategory != 0 {
                _hit += 1
                let dx = -3 + CommonUtil.rnd(7)
                
                secondBody.applyImpulse(CGVectorMake(-1,0))
                updateHit()
            }
        }
    }
    
    func updateHit(){
        var label : SKLabelNode? = childNodeWithName("hit") as? SKLabelNode
        label?.text = "ゴーストに当てた数：\(_hit)"
        label?.zPosition = 3
    }
    
    
}

