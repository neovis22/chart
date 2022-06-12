#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include <chart/chart>
#Include <gdip_all/gdip_all>

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

/*
    Light theme
*/
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Bar").data(gen(5)).data(gen(5)).title("Bar").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "BarH").data(gen(5)).title("BarH").plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Bubble").data(gen(5)).data(gen(5)).title("Bubble").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Scatter").data(gen(50)).data(gen(50)).title("Scatter").plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Doughnut").data(gen(5)).title("Doughnut").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Pie").data(gen(5)).title("Pie").plot()
Gui Add, Text, ym w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5)).data(gen(5)).title("Line").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5), {radius:0}).data(gen(5), {radius:0}).title("Line").plot()

/*
    Dark theme
*/
Gui Add, Text, xm w300 h200 Section Hwndhwnd
chart(hwnd, "Bar").data(gen(5)).data(gen(5)).title("Bar").theme("dark").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "BarH").data(gen(5)).title("BarH").theme("dark").plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Bubble").data(gen(5)).data(gen(5)).title("Bubble").theme("dark").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Scatter").data(gen(50)).data(gen(50)).title("Scatter").theme("dark").plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Doughnut").data(gen(5)).title("Doughnut").theme("dark").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Pie").data(gen(5)).title("Pie").theme("dark").plot()
Gui Add, Text, ys w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5)).data(gen(5)).title("Line").theme("dark").plot()
Gui Add, Text, w300 h200 Hwndhwnd
chart(hwnd, "Line").data(gen(5), {radius:0}).data(gen(5), {radius:0}).title("Line").theme("dark").plot()

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
