// 盗賊に転職
class JobProducerScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "P"
        _skill_name     = SkillSetting.getName("producer")
        _skill_explain  = SkillSetting.getExplain("producer")
        
        _str_up = 1
        _def_up = 0
        _int_up = 1
        _pri_up = 0
        _agi_up = 0
        _luck_up = 1
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_producer", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("笑顔な", percent: 10)
        changeNickname("すごい", percent: 10)
    }
}

