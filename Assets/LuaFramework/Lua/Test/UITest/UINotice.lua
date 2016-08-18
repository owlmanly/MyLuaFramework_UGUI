local UINotice = class("UINotice",UIBasePage)

function UINotice:ctor()
    UIBasePage:ctor()
    self.uiType = UIType.PopUp
    self.uiMode = UIMode.DoNothing
    self.uiColider = UICollider.None
    self.uiPrefab = "Notice"
    self.abName = "uiprefab"
end
function UINotice:OnInit()
    
    assert(UIHelper.bindButtonClick(self.gameObject,"btn_confim",function()
              UI:HidePage("UINotice")
        end))
end

function UINotice:OnShow()
    self.super.OnShow(self)
    
end

--隐藏
function UINotice:OnHide()
    self.super.OnHide(self)
    
end

return UINotice