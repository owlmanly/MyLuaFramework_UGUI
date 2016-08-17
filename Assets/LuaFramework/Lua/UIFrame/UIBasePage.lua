--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
UIBasePage = class("UIBasePage")

function UIBasePage:ctor()
    --继承需要设置参数
    self.uiType = UIType.Normal
    self.uiMode = UIMode.DoNothing
    self.uiColider = UICollider.None
    self.uiPrefab = ""
    self.abName = ""
    --不需要设置
    self.gameObject = nil
    self.pageData = nil
    self.isAsyncUI = false
end

--显示
function UIBasePage:OnShow()
    self.gameObject:SetActive(true)
end

--隐藏
function UIBasePage:OnHide()
    self.gameObject:SetActive(false)
end

--销毁
function UIBasePage:OnDestroy()
    GameObject.Destroy(self.gameObject)
end

function UIBasePage:isActive()
  local ret = self.gameObject ~=nil and self.gameObject.activeSelf
  return ret
end

--endregion
