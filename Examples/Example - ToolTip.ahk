#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Add, Pic, xm w600 h300 0xE Hwndhwnd
chart := chart(hwnd, "Line").title("Chart").labels("Item 1,Item 2")
chart.xAxis.title("X Axis").labels("Apple,Lime,Mango,Orange,Banana")
chart.yAxis.title("Y Axis").range(0, 100).grid(5)

loop 2 {
    chart.data(data := [])
    loop 10 {
        Random n, 0, 100
        data.push(n)
    }
}
chart.plot()

Gui Show

OnMessage(0x200, "onHover") ; WM_MOUSEMOVE

onHover(wparam, lparam, msg, hwnd) {
    global chart
    MouseGetPos,,,, hwnd, 2
    if (chart.hwnd == hwnd) {
        VarSetCapacity(pt, 8, 0)
        DllCall("GetCursorPos", "ptr",&pt)
        DllCall("ScreenToClient", "ptr",hwnd, "ptr",&pt)
        ToolTip % chart.at(NumGet(pt, 0, "int"), NumGet(pt, 4, "int"))
    }
}

guiClose() {
    exitapp
}
