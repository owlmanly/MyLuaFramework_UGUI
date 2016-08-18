--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
require "UIFrame/UIBasePage"

local UIManager = {}

function UIManager:Init(args)
    --UIRoot
    self.UIRoot = require("UIFrame/UIRoot").New()
    
    --所有已经加载的Pages 缓存
    self.allPages = {}
    --当前正在显示的Pages
    self.currentPageNodes = {}
    --
end

--打开窗口
function UIManager:ShowPage(pageId,fnCallback,pageData,isAsync)

    local pagePath = UIPageID[pageId]
    log("show page = " .. pageId)
    assert(pagePath,"pagePath not find")
    local page = nil
    if table.containKey(self.allPages,pageId) then 
      page = self.allPages[pageId]
    else
      page = require(pagePath).New()
      self.allPages[pageId] = page
    end
    
    page.pageData = pageData
    if isAsync then
      self:_AsyncShow(page,fnCallback)
    else
      self:_Show(page,fnCallback)
    end
end

--
function UIManager:_Show(page,fn)
    if page.gameObject == nil then
      log("abName = "..page.abName..AppConst.ExtName)
      log("prefab = "..page.uiPrefab)
      resMgr:LoadPrefab(page.abName..AppConst.ExtName, { page.uiPrefab }, function(objs)
          local prefab = objs[0]
          local go = GameObject.Instantiate(prefab)
          page.gameObject = go
          self:_AnchorUIGameObject(page)
          page:OnInit()
          page:OnShow()
          self:_PopPage(page)
          if fn then
            fn()
          end
        end);
    else
      page:OnShow()
      self:_PopPage(page)
      if fn then
        fn()
      end
    end
    
end

function UIManager:_AsyncShow(page,fn)
    StartCoroutine(function(page,fn)
        _Show(page,fn)
      end)
end

function UIManager:_AnchorUIGameObject(page)
  if page == nil or page.gameObject == nil then
    return 
  end
  local parent = self.UIRoot:GetRoot(page.uiType)
  page.gameObject.transform:SetParent(parent.transform,false)

end

function UIManager:_PopPage(page)
  assert(page,"page is nil")
  if self:_CheckNeedBack(page) == false then 
    return 
  end
  
  for key, var in ipairs(self.currentPageNodes) do
    if var == page then
      table.remove(self.currentPageNodes,key)
    end
  end
  table.insert(self.currentPageNodes,page)
  self:HideOldNodes(page)
end

function UIManager:_CheckNeedBack(page)
  assert(page,"page is nil")
  if page.uiType == UIType.Fixed or page.uiType == UIType.PopUp then
    return false
  elseif page.uiMode == UIMode.DoNothing or page.uiMode == UIMode.NoNeedBack then 
    return false
  end
  return true
end

function UIManager:HideOldNodes(page)
  if table.nums(self.currentPageNodes) < 0 then
    return
  end
  if page.uiMode == UIMode.HideOther then
    for i = table.nums(self.currentPageNodes)-1,1,-1 do
      log("hideOldNode i = " .. i)
      local pageNode = self.currentPageNodes[i]
      if pageNode:isActive() then
        pageNode:OnHide()
      end
    end
  end
end

--隐藏窗口
function UIManager:HidePage(pageId)
    local page = self.allPages[pageId]
    assert(page,"page is nil")
    self:_HidePage(page)
end

function UIManager:_HidePage(page)
    if page:isActive() == false then
        for key ,var in ipairs(self.currentPageNodes) do
          if page == var then
            table.remove(self.currentPageNodes,key)
          end
        end
    end
    local num = table.nums(self.currentPageNodes)
    
    if num > 1 and self.currentPageNodes[num] == page then
      self.currentPageNodes[num] = nil
      local prePage = self.currentPageNodes[num-1]
      self:_Show(prePage)
      page:OnHide()
    end
    
    if self:_CheckNeedBack(page) then
      for key ,var in ipairs(self.currentPageNodes) do
          if page == var then
            table.remove(self.currentPageNodes,key)
          end
        end
    end
    page:OnHide()
  
end

function UIManager:AutoHidePage()
  local num = table.nums(self.currentPageNodes)
  if num <= 1 then
    return
  end
  log("currentPageNodes num = " .. num)
  local closePage 
  if num > 0 then 
    closePage = self.currentPageNodes[num]
    table.remove(self.currentPageNodes,num)
  end
  num = table.nums(self.currentPageNodes)
  log("after remove ,currentPageNodes num = " .. num)
  if num > 0 then 
    local prePage = self.currentPageNodes[num]
    self:_Show(prePage)
    closePage:OnHide()
  end
  
end


--隐藏所有已经打开的窗口
function UIManager:HideAllShownPage()
    
end

--清除所有窗口
function UIManager:ClearAllPage()
  
end


UIManager:Init()

return UIManager

--endregion