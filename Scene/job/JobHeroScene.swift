// 勝負師に転職
class JobHeroScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "勇者"
        _skill_name     = SkillSetting.getName("hero")
        _skill_explain  = SkillSetting.getExplain("hero")
        
        _str_up = 1
        _def_up = 1
        _int_up = 1
        _pri_up = 1
        _agi_up = 1
        _luck_up = 1
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_hero", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("君こそ", percent: 10)
        changeNickname("僕らの", percent: 10)
    }
}

