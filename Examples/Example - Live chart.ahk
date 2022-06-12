#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include <chart/chart>
#Include <gdip_all/gdip_all>

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Add, Text, xm w600 h350 Hwndhwnd
chart := chart(hwnd, "line")
chart.data(data := [], {radius:2, color:0x90D4D3})
chart.yAxis.range(0, 100).grid(5)

Gui Show
Gui +Hwndhwnd -SysMenu
Gui Show,, % " "
SetWindowNoDrawIcon(hwnd)

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

SetWindowNoDrawIcon(hwnd) {
    return SetWindowThemeAttribute(hwnd, 6) ; WTNCA_NODRAWICON | WTNCA_NOSYSMENU
}

SetWindowThemeAttribute(hwnd, flag) {
    /*
        WTNCA Values:
            WTNCA_NODRAWCAPTION := 1
            WTNCA_NODRAWICON := 2
            WTNCA_NOSYSMENU := 4
            WTNCA_NOMIRRORHELP := 8
    */
    return DllCall("UxTheme\SetWindowThemeAttribute"
        , "ptr",hwnd
        , "int",1
        , "int64*",flag | flag << 32 ; struct WTA_OPTIONS { DWORD dwFlags; DWORD dwMask; }
        , "uint",8)
}