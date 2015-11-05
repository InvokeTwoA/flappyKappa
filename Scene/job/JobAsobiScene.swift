// 遊び人に転職
class JobAsobiScene : JobBaseScene {
    
    override func setJobData() {
        _job_name       = "遊び人"
        _skill_name     = SkillSetting.getName("asobi")
        _skill_explain  = SkillSetting.getExplain("asobi")
        
        _str_up = 0
        _def_up = 0
        _int_up = 1
        _pri_up = 2
        _agi_up = 4
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_asobi", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("チャラい", percent: 10)
        changeNickname("世紀末", percent: 10)
    }
}

