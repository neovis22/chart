#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Add, Pic, xm w600 h300 0xE Hwndhwnd
chart := chart(hwnd, "Bar").theme("dark")
chart.yAxis.range(0, 100).grid(5)
chart.render := Func("chart_drawValue")

loop 2 {
    chart.data(data := [])
    loop 5 {
        Random n, 0, 100
        data.push(n)
    }
}
chart.plot()

Gui Show

chart_drawValue(chart, g) {
    chart.base.render.call(chart, g)
    
    tr := new chart.TextRenderer("Center vCenter Bold", "Segoe UI")
    tr.color := chart.color
    switch (chart.type) {
        case "Bar", "BarV":
            Gdip_RotateWorldTransform(g, -90)
            for i, v in chart.elements {
                tr.x := -(v.y+v.height)
                tr.y := v.x
                tr.width := Max(v.height, 60)
                tr.height := v.width
                tr.render(g, v.value)
            }
            Gdip_ResetWorldTransform(g)
        case "BarH":
            for i, v in chart.elements {
                tr.x := v.x
                tr.y := v.y
                tr.width := v.width
                tr.height := v.height
                tr.render(g, v.value)
            }
    }
}

guiClose() {
    exitapp
}
