import Foundation

class SkillSetting {
    
    class func getName(key_name :String) -> String {
        var name : String
        switch key_name {
        case "wizard":
            name = "カッパ怒りの炎"
        case "warrior":
            name = "流し斬り"
        case "priest":
            name = "カッパの祈り"
        case "thief":
            name = "トレハン"
            
        case "break_block":
            name = "ブロック崩し"
        case "blood":
            name = "吸血"
        case "zombi":
            name = "河童オブ・ザ・デッド"
        case "shoes":
            name = "縮地"
        default:
            name = ""
        }
        return name
    }
    
    
    class func getExplain(key_name :String) -> String {
        var name : String
        switch key_name {
        case "wizard":
            name = "ファイアボールが早くなり、敵を貫通します"
        case "warrior":
            name = "物理攻撃の速度が２倍になります。\n"
        case "priest":
            name = "回復アイテムの出現率が２倍になります。\n安全第一ですな。"
        case "thief":
            name = "レア報酬の取得率が２倍になります。\n やったね。"
            
        case "break_block":
            name = "物理攻撃でブロックを破壊できます。\n すごーい。"
        case "blood":
            name = "敵を撃破する度にHPが回復するようになります。\n回復量はレベル依存です。\n\n異名がゾンビの時だけ有効になります。"
        case "zombi":
            name = "回復アイテムを取ると大ダメージを受けてしまいます。\n\n異名がゾンビの時だけ有効になります。"
        case "shoes":
            let agi_max = CommonConst.agi_max
            name = "戦闘中の敏捷が\(agi_max)になる。\n速すぎるので注意"
        default:
            name = ""
        }
        return name
    }
}