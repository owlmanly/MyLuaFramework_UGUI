--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

--窗口类型
UIType = {
    Normal = 1, -- 可推出界面(UIMainMenu,UIRank等)
    Fixed = 2, --固定窗口(UITopBar等)
    PopUp = 3,     -- 模式窗口
}

UIMode =
{
    DoNothing = 1,
    HideOther = 2,     -- 闭其他界面
    NeedBack = 3,      -- 点击返回按钮关闭当前,不关闭其他界面(需要调整好层级关系)
    NoNeedBack = 4,    -- 关闭TopBar,关闭其他界面,不加入backSequence队列
}

UICollider =
{
    None = 1,      -- 显示该界面不包含碰撞背景
    Normal = 2,    -- 碰撞透明背景
    WithBg = 3,    -- 碰撞非透明背景
}

UIPageID = 
{
    --INVALID = "invalid",
    Prompt = "Controller/PromptCtrl",
    UITopBar = "Test/UITest/UITopBar",
    UIMainPage = "Test/UITest/UIMainPage",
    UINotice = "Test/UITest/UINotice",
    UISkillPage = "Test/UITest/UISkillPage",
    UIBattle = "Test/UITest/UIBattle",
}

--endregion
