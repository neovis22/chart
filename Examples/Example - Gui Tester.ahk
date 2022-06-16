#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include *i <init>
#Include %a_lineFile%/../../chart.ahk
#Include %a_lineFile%/../../gdip_all.ahk

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Margin, 10, 6
Gui Font,, Segoe UI

/*
    Chart
*/
Gui Add, GroupBox, % "xm ym w600 h" 28*6+10, Chart

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vtitle, Title of Chart

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdateData vlabels, Before,Now

Gui Add, Text, xs w80 h22 0x200, Data Count
Gui Add, Edit, x+m w180 hp gupdateData
Gui Add, UpDown, vyGrid gupdateData vdataCount, 5
Gui Add, Button, x+m hp gupdateData, Random Data

Gui Add, Text, xs w80 h22 0x200, Type
for type in Charter.charts
    Gui Add, Button, x+m hp gupdateType, % type

Gui Add, Text, xs w80 h22 0x200
Gui Add, Checkbox, x+m hp gupdate vdebugmode, Debug Mode

/*
    X Axis
*/
Gui Add, GroupBox, % "xm y+20 w600 h" 28*4+10, X Axis

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vxTitle, Title of X Axis

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdate vxLabels, Apple,Mango,Orange,Banana,Lime

Gui Add, Text, xs w80 h22 0x200, Label Format
Gui Add, Edit, x+m w270 hp gupdate vxFormat

Gui Add, Text, x+m w80 h22 0x200, Grid Count
Gui Add, Edit, x+m w100 hp gupdate
Gui Add, UpDown, vxGrid gupdate

/*
    Y Axis
*/
Gui Add, GroupBox, % "xm y+20 w600 h" 28*4+10, Y Axis

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vyTitle, Title of Y Axis

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdate vyLabels

Gui Add, Text, xs w80 h22 0x200, Label Format
Gui Add, Edit, x+m w270 hp gupdate vyFormat, {:.2f}

Gui Add, Text, x+m w80 h22 0x200, Grid Count
Gui Add, Edit, x+m w100 hp gupdate
Gui Add, UpDown, vyGrid gupdate

Gui Add, Text, xm w600 h350 Hwndhwnd
chart := chart(hwnd, "Line")

; chart.border(5)
; chart.title.margin(50)
; chart.title.padding(50)
chart.yAxis.label.padding(50)
chart.xAxis.label.padding(50)

Gui Show

updateData()
return

updateType() {
    global
    chart.type(a_guiControl)
    update()
}

updateData() {
    global
    GuiControlGet dataCount
    chart.datasets := [] ; 데이터 초기화
    loop % StrSplit(labels, ",").count()
        chart.data(gen(dataCount))
    update()
}

update() {
    SetTimer updateChart, -1
}

updateChart() {
    global
    Gui Submit, NoHide
    Charter.debugmode := debugmode
    chart.title(title).labels(labels)
    chart.xAxis.title(xTitle).labels(xLabels).format(xFormat).grid(xGrid)
    chart.yAxis.title(yTitle).labels(yLabels).format(yFormat).grid(yGrid)
    chart.plot()
}

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
