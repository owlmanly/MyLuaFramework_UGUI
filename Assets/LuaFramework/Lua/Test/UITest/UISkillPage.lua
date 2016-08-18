local UISkillPage = class("UISkillPage",UIBasePage)

function UISkillPage:ctor()
    UIBasePage:ctor()
    self.uiType = UIType.Normal
    self.uiMode = UIMode.HideOther
    self.uiColider = UICollider.None
    self.uiPrefab = "UISkill"
    self.abName = "uiprefab"
end
function UISkillPage:OnInit()
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_upgrade",function()
              
        end))
end

function UISkillPage:OnShow()
    self.super.OnShow(self)
    
end

--隐藏
function UISkillPage:OnHide()
    self.super.OnHide(self)
    
end

return UISkillPage