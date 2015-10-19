// 僧侶に転職
class JobPriestScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "僧侶"
        _skill_name     = SkillSetting.getName("priest")
        _skill_explain  = SkillSetting.getExplain("priest")
        
        _str_up = 0
        _def_up = 1
        _int_up = 0
        _pri_up = 1
        _agi_up = 0
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_priest", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("聖なる", percent: 10)
        changeNickname("真面目な", percent: 10)
        changeNickname("イエスマン", percent: 10)
    }
}

