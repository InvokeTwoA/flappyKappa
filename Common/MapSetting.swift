import Foundation
import SpriteKit

class MapSetting {
    class func nextScene(size : CGSize) -> SKScene {
        var nextScene : SKScene
        let name : String = CommonData.getDataByString("stage_name")
        if name == "slime" {
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
        } else if name == "noukin" {
            nextScene = NoukinStageScene(size: size)
            return nextScene
        } else if name == "taiman" {
            nextScene = TaimanStageScene(size: size)
            return nextScene
        } else if name == "maho" {
            nextScene = MahoStageScene(size: size)
            return nextScene
        } else if name == "kabe" {
            nextScene = KabeStageScene(size: size)
            return nextScene
        } else if name == "mugen" {
            nextScene = MugenStageScene(size: size)
            return nextScene
        } else {
            nextScene = SlimeStageScene(size: size)
            return nextScene
        }
    }
    
    class func getName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "slime":
            name = "スライムの洞窟"
        case "tanuki":
            name = "スカーフ山"
        case "golem":
            name = "アノーレ・ロンド遺跡"
        case "dojo_g":
            name = "サイレント昼"
        case "maou":
            name = "魔王城"
        case "noukin":
            name = "脳筋ダンジョン"
        case "taiman":
            name = "FEコロシアム"
        case "maho":
            name = "魔法科中学校"
        case "kabe":
            name = "デスマス城"
        case "mugen":
            name = "無限の住人"
        default:
            name = ""
        }
        return name
    }

    class func getBossName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "slime":
            name = "デカイム"
        case "tanuki":
            name = "留年騎士"
        case "golem":
            name = "メガデス"
        case "dojo_g":
            name = "元勇者"
        case "maou":
            name = "魔王"
        case "noukin":
            name = "留年騎士"
        case "taiman":
            name = "元勇者"
        case "maho":
            name = "メガデス"
        case "kabe":
            name = "デカイム"
        case "mugen":
            name = "魔王"
        default:
            name = ""
        }
        return name
    }
    
    class func getExplain1(key_name :String) -> String {
        var name : String
        switch key_name {
        case "slime":
            name = "初心者冒険者が訪れる簡単な洞窟"
        case "tanuki":
            name = "中級冒険者が腕試しに挑む高山"
        case "golem":
            name = "心が折れるダンジョン"
        case "dojo_g":
            name = "無事に昼を迎えた者はいない"
        case "maou":
            name = "全ては闇に包まれている"
        case "noukin":
            name = "ここでは魔法が使えない"
        case "taiman":
            name = "一対一の勝負"
        case "maho":
            name = "ここでは魔法しか使えない"
        case "kabe":
            name = "初見殺しステージ"
        case "mugen":
            name = "やり込みたい人向け"
        default:
            name = ""
        }
        return name
    }

    class func getExplain2(key_name :String) -> String {
        var name : String
        switch key_name {
        case "slime":
            name = "ここで基本操作を覚えると良い。"
        case "tanuki":
            name = "レベルや装備は整えたか？"
        case "golem":
            name = "ハンマーなどの装備推奨"
        case "dojo_g":
            name = "ボスは魔法か会心の一撃が有効"
        case "maou":
            name = ""
        case "noukin":
            name = "筋肉大好きな人集まれー"
        case "taiman":
            name = "敏捷ちゃんと上げてる？"
        case "mugen":
            name = "全ボス登場の最高難易度ステージ"
        default:
            name = ""
        }
        return name
    }

    class func getExplain3(key_name :String) -> String {
        var name : String
        switch key_name {
        case "slime":
            name = "レア報酬：オレ杖"
        case "tanuki":
            name = "レア報酬：1000ゴールド"
        case "golem":
            name = "レア報酬：カッパソウル"
        case "dojo_g":
            name = "レア報酬：重力子放射線射出装置"
        case "maou":
            name = ""
        case "noukin":
            name = "レア報酬：マッチョ薬（HP+3）"
        case "taiman":
            name = "レア報酬：枝豆（知、精の成長up）"
        case "maho":
            name = "LVが１になる"
        case "kabe":
            name = "聖シャインの剣"
        case "kabe":
            name = "レア報酬などない"            
        default:
            name = ""
        }
        return name
    }    
}