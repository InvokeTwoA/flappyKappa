import Foundation
import SpriteKit

class MapSetting {
    class func nextScene(size : CGSize) -> SKScene {
        var nextScene : SKScene
        let name : String = CommonData.getDataByString("stage_name")
        if name == "tutorial" {
            nextScene = TutorialStageScene(size: size)
            return nextScene
        } else if name == "slime" {
            nextScene = SlimeStageScene(size: size)
            return nextScene
        } else if name == "tanuki" {
            nextScene = TanukiStageScene(size: size)
            return nextScene
        } else if name == "golem" {
            nextScene = GolemStageScene(size: size)
            return nextScene
        } else if name == "dojo_g" {
            nextScene = DojoGStageScene(size: size)
            return nextScene
        } else if name == "maou" {
            nextScene = MaoStageScene(size: size)
            return nextScene
        } else {
            nextScene = SlimeStageScene(size: size)
            return nextScene
        }
    }
    
    
    
    class func getName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "long":
            name = "ロンゲソード"
        case "katana":
            name = "逆刃刀"
        case "shoes":
            name = "ネコの長靴"
        case "hammer":
            name = "10トンハンマー"
        default:
            name = "a"
        }
        return name
    }
    
    class func getCost(key_name :String) -> Int {
        var cost : Int
        switch key_name {
        case "long":
            cost = 10
        case "katana":
            cost = 15
        case "shoes":
            cost = 3
        case "hammer":
            cost = 20
        default:
            cost = 0
            break // do nothing
        }
        return cost
    }
    
    class func getExplain(key_name :String) -> String {
        var name : String
        switch key_name {
        case "long":
            name = "定価\(getCost(key_name))ゴールド\n\nロンゲの兄ちゃんが使ってた剣。\n\n スキル[ブロック崩し]\nブロックを破壊できます。"
        case "katana":
            name = "定価\(getCost(key_name))ゴールド\n\n殴られると相当痛い刀。\n\n スキル[龍墜閃]\nクリティカル率が100%になります。\n戦闘中の最大HPが2になります"
        case "shoes":
            let agi_max = CommonConst.agi_max
            name = "定価\(getCost(key_name))ゴールド\n\nとんでもなく早く動ける靴。\n\n スキル[縮地]\n戦闘中の敏捷が\(agi_max)になる。\n速すぎるので注意"
        default:
            name = "a"
        }
        return name
    }
    
    // 重力子放射線射出装置
    
}