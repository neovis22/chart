#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

/*
    Light theme
*/
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Bar").data(gen(5)).data(gen(5)).title("Bar").theme("light", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "BarH").data(gen(5)).title("BarH").theme("light", 1).plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Bubble").data(gen(5)).data(gen(5)).title("Bubble").theme("light", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Scatter").data(gen(50)).data(gen(50)).title("Scatter").theme("light", 1).plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Doughnut").data(gen(5)).title("Doughnut").theme("light", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Pie").data(gen(5)).title("Pie").theme("light", 1).plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5)).data(gen(5)).title("Line").theme("light", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5), {radius:0}).data(gen(5), {radius:0}).title("Line").theme("light", 1).plot()

/*
    Dark theme
*/
Gui Add, Text, xm w300 h200 Section Hwndhwnd
chart(hwnd, "Bar").data(gen(5)).data(gen(5)).title("Bar").theme("dark", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "BarH").data(gen(5)).title("BarH").theme("dark", 1).plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Bubble").data(gen(5)).data(gen(5)).title("Bubble").theme("dark", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Scatter").data(gen(50)).data(gen(50)).title("Scatter").theme("dark", 1).plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Doughnut").data(gen(5)).title("Doughnut").theme("dark", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Pie").data(gen(5)).title("Pie").theme("dark", 1).plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5)).data(gen(5)).title("Line").theme("dark", 1).plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5), {radius:0}).data(gen(5), {radius:0}).title("Line").theme("dark", 1).plot()

Gui Show
return

guiClose() {
    exitapp
}

gen(length) {
    data := []
    loop % length
        data.push([gauss(), gauss(), gauss()])
    return data
}

gauss(factor=6) {
    x := 0
    loop % factor {
        Random n, 0.0, 1.0
        x += n
    }
    return x/factor
}
