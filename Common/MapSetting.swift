import Foundation
import SpriteKit

class MapSetting {
    class func nextScene(size : CGSize) -> SKScene {
        let name : String = CommonData.getDataByString("stage_name")
        if name == "slime" {
            return SlimeStageScene(size: size)
        } else if name == "tanuki" {
            return TanukiStageScene(size: size)
        } else if name == "golem" {
            return GolemStageScene(size: size)
        } else if name == "dojo_g" {
            return DojoGStageScene(size: size)
        } else if name == "maou" {
            return MaoStageScene(size: size)
        } else if name == "noukin" {
            return NoukinStageScene(size: size)
        } else if name == "taiman" {
            return TaimanStageScene(size: size)
        } else if name == "maho" {
            return MahoStageScene(size: size)
        } else if name == "kabe" {
            return KabeStageScene(size: size)
        } else if name == "mugen" {
            return MugenStageScene(size: size)
        } else if name == "odon" {
            return OdonStageScene(size: size)
        } else if name == "seizon" {
            return SeizonStageScene(size: size)
        } else if name == "white" {
            return WhiteStageScene(size: size)
        } else if name == "kettou" {
            return KettouStageScene(size: size)
        } else {
            return SlimeStageScene(size: size)
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
            name = "FE闘技場"
        case "maho":
            name = "魔法科中学校"
        case "kabe":
            name = "デスマス城"
        case "mugen":
            name = "無限の住人"
        case "odon":
            name = "オデン教会"
        case "seizon":
            name = "生存率3%"
        case "white":
            name = "ホワイトベース"
        case "kettou":
            name = "１対１の決闘"
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
        case "odon":
            name = "メガデス"
        case "seizon":
            name = "メガデス"
        case "white":
            name = "鏡の騎士"
        case "kettou":
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
        case "odon":
            name = "ここは床に触れるとダメージ"
        case "seizon":
            name = "ここはHPが1の状態で戦う"
        case "white":
            name = "雪が全てを白く染めている。"
        case "kettou":
            name = "魔王と１対１で戦ってみよう"
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
        case "odon":
            name = "儲けやすいステージは見つけた？"
        case "seizon":
            name = "一瞬の油断が命取り"
        case "white":
            name = "敵の動きの法則性を見極めろ！"
        case "kettou":
            name = "魔王はワープと共に大量の敵を召喚"
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
            name = "レア報酬：LVが１になる"
        case "kabe":
            name = "レア報酬：聖シャインの剣"
        case "mugen":
            name = "報酬：真のエンディング"
        case "odon":
            name = "レア報酬：紹介状"
        case "seizon":
            name = "レア報酬：たぬきブリンガー"
        case "white":
            name = "レア報酬：魔王城の鍵"
        case "kettou":
            name = "レア報酬：カッパソード"
        default:
            name = ""
        }
        return name
    }    
}