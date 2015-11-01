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
        case "daiku":
            name = "工事"
        case "producer":
            name = "笑顔です"
        case "akagi":
            name = "燕返し"
        case "hero":
            name = "カッパスラッシュ"
        case "kenja":
            name = "瞑想（居眠り）"
        case "asobi":
            name = "明日があるさ"
        default:
            name = ""
        }
        return name
    }
    
    class func getExplain(key_name :String) -> String {
        var name : String
        switch key_name {
        case "wizard":
            name = "ファイアボールが敵を貫通します。\n敵を一網打尽だ！"
        case "warrior":
            name = "物理攻撃の速度が２倍になります。\n太刀筋が寝ぼけてるよ！"
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
        case "daiku":
            name = "ブロックを壊せるようになる"
        case "producer":
            name = "幸運%で被ダメージを1にする。\n"
        case "akagi":
            name = "ステージクリア後、冒険日数と同額のゴールドを得る。\n"
        case "hero":
            name = "戦闘中の攻撃力と知恵に精神の値を加算。\n"
        case "kenja":
            name = "戦闘中、時間経過と共にHPが1回復 \n"
        case "asobi":
            name = "すぐにボスと戦う事ができる。\n\nズルしちゃえー"
        default:
            name = ""
        }
        return name
    }
}