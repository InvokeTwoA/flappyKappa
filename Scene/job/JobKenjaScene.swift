// 勝負師に転職
class JobKenjaScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "賢者"
        _skill_name     = SkillSetting.getName("kenja")
        _skill_explain  = SkillSetting.getExplain("kenja")
        
        _str_up = 0
        _def_up = 0
        _int_up = 4
        _pri_up = 0
        _agi_up = 0
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_kenja", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("謎の", percent: 10)
        changeNickname("黒の", percent: 10)
    }
}

