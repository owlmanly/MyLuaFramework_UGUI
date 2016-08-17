
local UIRoot = class("UIRoot")

function UIRoot:ctor()
    self.uiRoot = nil
    self.normalRoot = nil
    self.fixedRoot = nil
    self.popuRoot = nil
    
    self:CreateRoot()
end


function CreateSubCanvasForRoot(name ,root, sort)

    local go = GameObject.New(name)
    go.transform.parent = root
    go.layer = LayerMask.NameToLayer("UI")

    local can = go:AddComponent(typeof(Canvas))
    local rect = go:GetComponent(typeof(RectTransform))
    rect:SetInsetAndSizeFromParentEdge(RectTransform.Edge.Left,0,0)
    rect:SetInsetAndSizeFromParentEdge(RectTransform.Edge.Top,0,0)
    rect.anchorMin = Vector2.zero
    rect.anchorMax = Vector2.one

    can.overrideSorting = true
    can.sortingOrder = sort

    go:AddComponent(typeof(GraphicRaycaster))

    return go;

end

function UIRoot:CreateRoot()
    
    local go = GameObject.New("UIRoot")
    self.uiRoot = go
    go.layer = LayerMask.NameToLayer("UI")
    go:AddComponent(typeof(RectTransform))

    local canvas = go:AddComponent(typeof(Canvas))
    canvas.renderMode = RenderMode.ScreenSpaceCamera
    canvas.pixelPerfect = true

    local uicamera = GameObject.New("UICamera")
    uicamera.layer = LayerMask.NameToLayer("UI")
    uicamera.transform.parent = go.transform
    uicamera.transform.localPosition = Vector3.New(0,0,-100)
    local cam = uicamera:AddComponent(typeof(Camera))
    cam.clearFlags = CameraClearFlags.Depth
    cam.orthographic = true
    cam.farClipPlane = 200
    cam.cullingMask = 32 -- 1 << 5
    cam.nearClipPlane = -50
    cam.farClipPlane = 50

    --add audio listener
    --uicamera:AddComponent(typeof(AudioListener));
    --uicamera:AddComponent(typeof(GUILayer));

    local cs = go:AddComponent(typeof(CanvasScaler))
    cs.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize
    cs.referenceResolution = Vector2.New(1136, 640)
    cs.screenMatchMode = CanvasScaler.ScreenMatchMode.Expand

    self.normalRoot = CreateSubCanvasForRoot("NormalRoot",go.transform,0);

    self.fixedRoot = CreateSubCanvasForRoot("FixedRoot",go.transform,250);

    self.popuRoot = CreateSubCanvasForRoot("PopupRoot",go.transform,500);

     --add Event System
    local esObj = GameObject.Find("EventSystem")
    if(esObj ~= null) then
        GameObject.DestroyImmediate(esObj)
    end

    local eventObj = GameObject.New("EventSystem")
    eventObj.layer = LayerMask.NameToLayer("UI")
    eventObj.transform:SetParent(go.transform)
    eventObj:AddComponent(typeof(EventSystem))
    if not Application.isMobilePlatform or Application.isEditor then
        eventObj:AddComponent(typeof(UnityEngine.EventSystems.StandaloneInputModule))
    else
        eventObj:AddComponent(typeof(UnityEngine.EventSystems.TouchInputModule))
    end

end

function UIRoot:GetRoot(uiType)
  
  local parent = nil
  if uiType == UIType.Normal then
    parent = self.normalRoot
  else if uiType == UIType.Fixed then
    parent = self.fixedRoot
  else if uiType == UIType.PopUp then
    parent = self.popuRoot
  end
  return parent
  
end

return UIRoot