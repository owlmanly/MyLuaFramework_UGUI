--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

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
    
    local pageName = UIPageID[pageId]
    assert(pageName,"pageName not find")
    local page = nil
    if table.containKey(self.allPages,pageName) then 
      page = self.allPages[pageName]
    else
      page = require(pageName).New()
      self.allPages[pageName] = page
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
    if page.gameObjec == nil then
      resMgr:LoadPrefab(page.abName, { page.abName }, function(objs)
          local prefab = objs[1]
          local go = GameObject.Instantiate(prefab);
          page.gameObject = go
          page:OnShow()
          if fn then
            fn()
          end
        end);
    else
      page:OnShow()
      if fn then
        fn()
      end
    end
end

function UIManager:_AsyncShow(page,fn)
    StartCoroutine(function(page,fn)
        _Show(page,fn)
      end))
end

function UIManager:_AnchorUIGameObject(page)
  if page == nil || page.gameObject = nil then
    return 
  end
  local parent = self.UIRoot:GetRoot(page.uiType)
  page.gameOject.transform:SetParent(parent)

end

function UIManager:_PopPage(page)
  assert(page,"page is nil")
  if self:_CheckNeedBack(page) then 
    return 
  end
  
  for key, var in ipairs(self.currentPageNodes) do
    if var == page then
      self.currentPageNodes[key] = nil
    end
  end
  table.insert(self.currentPageNodes)
  self:HideOldNodes(page)
end

function UIManager:_CheckNeedBack(page)
  assert(page,"page is nil")
  if page.uiType == UIType.Fixed or page.uiType == UIType.PopUp then
    return false
  else if page.uiMode == UIMode.DoNothing or page.uiMode == UIMode.NoNeedBack then 
    return false
  end
  return true
end

function UIManager:HideOldNodes(page)
  if table.nums(self.currentPageNodes) < 0 then
    return
  end
  if page.uiMode == UIMode.HideOther then
    for i = table.nums(self.currentPageNodes)-1,0,-1 do
      local pageNode = self.currentPageNodes[i]
      if pageNode:isActive() then
        pageNode:OnHide()
      end
    end
  end
end

--隐藏窗口
function UIManager:HidePage(pageId)
    local pageName = UIPageID[pageId]
    assert(pageName,"pageName not find")
    local page = self.allPages[pageName]
    assert(pageName,"page is nil")
    _HidePage(page)
end

function UIManager:_HidePage(page)
    if pageNode:isActive() = false then
        for key ,var ipairs(self.currentPageNodes) do
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
