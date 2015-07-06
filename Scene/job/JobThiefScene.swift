// 盗賊に転職
class JobThiefScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "盗賊"
        _skill_name     = SkillSetting.getName("thief")
        _skill_explain  = SkillSetting.getExplain("thief")
        
        _str_up = 0
        _def_up = 0
        _int_up = 0
        _pri_up = 0
        _agi_up = 1
        _luck_up = 1
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_thief", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("こっそり", percent: 10)
        changeNickname("チョイわる", percent: 10)
        changeNickname("悪い", percent: 10)
    }
}

