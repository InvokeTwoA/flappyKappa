// 戦士に転職
class JobWarriorScene: JobBaseScene {

    override func setJobData() {
        _job_name       = "戦士"
        _skill_name = SkillSetting.getName("warrior")
        _skill_explain = SkillSetting.getExplain("warrior")
        
        _str_up = 1
        _def_up = 1
        _int_up = 0
        _pri_up = 0
        _agi_up = 0
        _luck_up = 0
    }
    
    // 転職後のパラメーター変化
    override func setJobSkill() {
        CommonData.setData("skill_warrior", value: 1)
    }
    
    override func changeNickname(){
        changeNickname("脳筋の", percent: 10)
        changeNickname("マッチョな", percent: 10)
        changeNickname("頑張り", percent: 10)
    }
}

