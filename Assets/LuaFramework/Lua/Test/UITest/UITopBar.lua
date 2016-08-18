local UITopBar = class("UITopBar",UIBasePage)

function UITopBar:ctor()
    UIBasePage:ctor()
    self.uiType = UIType.Fixed
    self.uiMode = UIMode.DoNothing
    self.uiColider = UICollider.None
    self.uiPrefab = "Topbar"
    self.abName = "uiprefab"
end
function UITopBar:OnInit()
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_back",function()
              UI:AutoHidePage()
        end))
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_notice",function()
              UI:ShowPage("UINotice")
        end))
end

function UITopBar:OnShow()
    self.super.OnShow(self)
    
end

--隐藏
function UITopBar:OnHide()
    self.super.OnHide(self)
    
end

return UITopBar