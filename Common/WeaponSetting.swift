import Foundation

class WeaponSetting {
    
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
        case "oretue":
            name = "オレ杖"
        case "soul":
            name = "カッパソウル"
        case "juryoku":
            name = "重力子放射線射出装置"
        case "shine":
            name = "聖シャインの剣"
        case "habel":
            name = "ハベルの鎧"
        case "kabuto":
            name = "安全メット"
        case "golden":
            name = "金の匙"
        case "bringer":
            name = "たぬきブリンガー"
        case "kappa_sword":
            name = "かっぱソード"
        default:
            name = "全裸"
        }
        return name
    }

    class func getCost(key_name :String) -> Int {
        var cost : Int
        switch key_name {
        case "long":
            cost = 20
        case "katana":
            cost = 5
        case "shoes":
            cost = 3
        case "hammer":
            cost = 100
        case "oretue":
            cost = 0
        case "juryoku":
            cost = 0
        case "shine":
            cost = 0
        case "habel":
            cost = 222
        case "kabuto":
            cost = 500
        case "golden":
            cost = 1100
        case "bringer":
            cost = 7777
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
            name = "定価\(getCost(key_name))ゴールド\n\nロンゲの兄ちゃんが使ってた剣。\n\n 戦闘中の力が８になる"
        case "katana":
            name = "定価\(getCost(key_name))ゴールド\n\n殴られると相当痛い刀。\n\n スキル[龍墜閃]\nクリティカル率が100%になります。\n戦闘中の最大HPが2になります"
        case "shoes":
            let agi_max = CommonConst.agi_max
            name = "定価\(getCost(key_name))ゴールド\n\nとんでもなく早く動ける靴。\n\n スキル[縮地]\n戦闘中の敏捷が\(agi_max)になる。\n速すぎるので注意"
        case "hammer":
            name = "定価\(getCost(key_name))ゴールド\n\n戦闘中の力が１あがる\n\nスキル[ブロック壊し]\nブロックを破壊できる"
        case "oretue":
            name = "戦闘中、知恵が５上がる"
        case "soul":
            name = "巨大化する。戦闘中の力とhpが２倍になる。ブロックも破壊できるようになる。"
        case "juryoku":
            name = "ファイアボールを５タップ毎に出せるようになる"
        case "shine":
            name = "物理ダメージの下限が、仕事の最高記録と同じ値になる"
        case "habel":
            name = "定価\(getCost(key_name))ゴールド\n\n重たい鎧。ある世界ではこの装備が大人気だった。\n\n戦闘中のHPが３倍になる。"
        case "kabuto":
            name = "定価\(getCost(key_name))ゴールド\n\n天井に頭をぶつけてもダメージを受けなくなる。\n\n連駄ゲーがしたいあなたに贈る一品。"
        case "golden":
            name = "定価\(getCost(key_name))ゴールド\n\nありがたいスプーン。\n\nブロックを壊せるようになる。ブロックを破壊した際に出現すするコインの金額が(1~幸運)ゴールドになる。"
        case "bringer":
            name = "定価\(getCost(key_name))ゴールド\n\n星神を裏切った罪で追放されたタヌキブリンガーの悲しみが込められた剣。手にしたものは緋色の恩恵を得ると言う。\n\n物理攻撃が５ダメージ固定になる。\n\n（ただし、クリティカルヒットの時は例外）\n\nスキル[ブロック壊し]\nブロックを破壊できる"
        case "kappa_sword":
            name = "伝説のカッパが使っていた伝説の剣。\n\n伝説的な威力がある。\n戦闘中は攻撃力が冒険日数と一緒の値になる。HPが30になってしまう。"
        default:
            name = "テキスト用意されてません"
        }
        return name
    }
}