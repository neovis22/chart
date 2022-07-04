#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

; https://www.autohotkey.com/boards/viewtopic.php?p=470991#p470991
Gui +E0x2080000 ; doublebuffering

Gui Add, Text, xm w600 h350 Hwndhwnd
chart := chart(hwnd, "line")
chart.data(data := [], {radius:2, color:0x90D4D3})
chart.yAxis.range(0, 100).grid(5)

Gui Show

p := 50
interval := 50
tc := a_tickCount
loop {
    Random offset, -10, 10
    data.push(p := Min(100, Max(0, p+offset)))
    if (data.length() > 100)
        data.removeAt(1)
    
    if (a_index > 100) {
        chart.plot()
        tc += interval
        Sleep % tc-a_tickCount
    }
}

guiClose() {
    exitapp
}
