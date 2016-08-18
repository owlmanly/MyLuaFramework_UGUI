using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine.Events;
using LuaInterface;

public static class UIHelper
{
    public static bool bindButtonClick(GameObject go, string btnName, LuaFunction func = null)
    {
        GameObject btn = FindChild(go, btnName);

        if (btn == null)
            return false;

        return AddButtonClick(btn, func);
    }

    public static bool bindToggleChange(GameObject go, string btnName, LuaFunction func = null)
    {
        GameObject obj = FindChild(go, btnName);

        if (obj == null)
            return false;
        Toggle toggle = obj.GetComponent<Toggle>();
        if (toggle == null)
            return false;
        UnityAction<bool> act = new UnityAction<bool>((isOn) => { func.Call(isOn); });
        toggle.onValueChanged.AddListener(act);
        return true;
    }

    public static bool AddButtonClick(GameObject go, LuaFunction func = null)
    {
        Button btn = go.GetComponent<Button>();

        if (btn == null)
            return false;

        UnityAction act = new UnityAction(() => { func.Call(); });
        btn.onClick.AddListener(act);

        return true;
    }

    // 遍历查找子物体
    public static GameObject FindChild(GameObject go, string name)
    {
        foreach (Transform child in go.transform)
        {
            if (child.name == name)
                return child.gameObject;

            GameObject result = FindChild(child.gameObject, name);
            if (result != null)
                return result;
        }
        return null;
    }
}
