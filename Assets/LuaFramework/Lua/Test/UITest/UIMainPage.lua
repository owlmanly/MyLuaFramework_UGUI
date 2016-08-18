local UIMainPage = class("UIMainPage",UIBasePage)

function UIMainPage:ctor()
    UIBasePage:ctor()
    self.uiType = UIType.Normal
    self.uiMode = UIMode.HideOther
    self.uiColider = UICollider.None
    self.uiPrefab = "UIMain"
    self.abName = "uiprefab"
end

function UIMainPage:OnInit()
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_skill",function()
              UI:ShowPage("UISkillPage")
        end))
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_battle",function()
              UI:ShowPage("UIBattle")
        end))
end

function UIMainPage:OnShow()
    self.super.OnShow(self)
    
end

--隐藏
function UIMainPage:OnHide()
    self.super.OnHide(self)
    
end

return UIMainPage