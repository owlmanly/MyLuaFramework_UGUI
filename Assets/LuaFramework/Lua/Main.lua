--主入口函数。从这里开始lua逻辑
require "UnityEngines"
require "Common/class"
require "Common/functions"
require "Common/utils"
require "Common/define"

function Main()					
    print("lua Main")
    UI = require "UIFrame/UIManager"
    
end

--场景切换通知
function OnLevelWasLoaded(level)
	Time.timeSinceLevelLoad = 0
end