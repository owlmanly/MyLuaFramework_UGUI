local UIBattle = class("UIBattle",UIBasePage)

function UIBattle:ctor()
    UIBasePage:ctor()
    self.uiType = UIType.Normal
    self.uiMode = UIMode.HideOther
    self.uiColider = UICollider.None
    self.uiPrefab = "UIBattle"
    self.abName = "uiprefab"
end
function UIBattle:OnInit()
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_skill",function()
              UI:ShowPage("UISkillPage")
        end))
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_battle",function()
              log("should load your battle scene!")
        end))
end

function UIBattle:OnShow()
    self.super.OnShow(self)
end

--隐藏
function UIBattle:OnHide()
    self.super.OnHide(self)
    
end

return UIBattle