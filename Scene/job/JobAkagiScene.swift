// 勝負師に転職
class JobAkagiScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "勝負師"
        _skill_name     = SkillSetting.getName("akagi")
        _skill_explain  = SkillSetting.getExplain("akagi")
        
        _str_up = 0
        _def_up = 0
        _int_up = 1
        _pri_up = 0
        _agi_up = 0
        _luck_up = 3
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_akagi", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("闇の", percent: 10)
        changeNickname("天才", percent: 10)
    }
}

