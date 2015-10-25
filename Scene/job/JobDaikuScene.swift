// 盗賊に転職
class JobDaikuScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "大工"
        _skill_name     = SkillSetting.getName("daiku")
        _skill_explain  = SkillSetting.getExplain("daiku")
        
        _str_up = 0
        _def_up = 1
        _int_up = 0
        _pri_up = 1
        _agi_up = 1
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_daiku", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("笑顔な", percent: 10)
        changeNickname("すごい", percent: 10)
    }
}

