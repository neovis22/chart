#NoEnv
#SingleInstance Force
#Include *i <init>

SetBatchLines -1

#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Add, Pic, xm w600 h300 0xE Hwndhwnd
chart := chart(hwnd, "Candlestick")
chart.xAxis.range(0, 400)
chart.yAxis.range(0, 400)

chart.data(data := [])
open := 200
loop 30 {
    close := open+randn(-50, 50)
    /*
        data: [open, close, high, low]
    */
    data.push([open, close, open+randn(0, 50), close-randn(0, 50)])
    open := close
}
chart.plot()

Gui Show

randn(min, max) {
    Random n, min, max
    return n
}

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
