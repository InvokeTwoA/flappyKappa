// 魔法使いに転職
class JobWizardScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "魔法使い"
        _skill_name     = SkillSetting.getName("wizard")
        _skill_explain  = SkillSetting.getExplain("wizard")
        
        _str_up = 0
        _def_up = 0
        _int_up = 1
        _pri_up = 1
        _agi_up = 0
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_fire", value: 1)
    }
    
    override func changeNickname() {
        changeNickname("むっつり", percent: 10)
        changeNickname("怪しい", percent: 10)
        changeNickname("マジカル", percent: 10)
    }
}

