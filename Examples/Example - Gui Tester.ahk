#NoEnv
#SingleInstance Force

SetBatchLines -1

#Include <init>
#Include <chart/chart>
#Include <gdip_all/gdip_all>

OnExit(Func("Gdip_Shutdown").bind(Gdip_Startup()))

Gui Margin, 10, 6
Gui Font,, Segoe UI

Gui Add, GroupBox, % "xm ym w600 h" 28*5+10, Chart

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vtitle, Title of Chart

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdate vlabels, Before,Now

Gui Add, Text, xs w80 h22 0x200, Data Count
Gui Add, Edit, x+m w180 hp gupdate vdataCount, 5

Gui Add, Text, xs w80 h22 0x200, Type
for type in Charter.charts
    ; BS_PUSHLIKE 0x1000
    Gui Add, Button, x+m hp gupdateType, % type

Gui Add, Text, xs w80 h22 0x200
Gui Add, Checkbox, x+m hp gupdate vdebugmode, Debug Mode

Gui Add, GroupBox, % "xm y+20 w600 h" 28*4+10, X Axis

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vxTitle, Title of X Axis

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdate vxLabels, Apple,Mango,Orange,Banana,Lime

Gui Add, Text, xs w80 h22 0x200, Label Format
Gui Add, Edit, x+m w470 hp gupdate vxFormat

Gui Add, GroupBox, % "xm y+20 w600 h" 28*4+10, Y Axis

Gui Add, Text, xp20 yp30 w80 h22 0x200 Section, Title
Gui Add, Edit, x+m w470 hp gupdate vyTitle, Title of Y Axis

Gui Add, Text, xs w80 h22 0x200, Labels
Gui Add, Edit, x+m w470 hp gupdate vyLabels, 0,100,200

Gui Add, Text, xs w80 h22 0x200, Label Format
Gui Add, Edit, x+m w470 hp gupdate vyFormat

Gui Add, Text, xm w600 h350 Hwndhwnd
chart := chart(hwnd)

Gui Show

update()
return

updateType() {
    global chart
    chart.type(a_guiControl)
    SetTimer updateChart, -1
}

update() {
    SetTimer updateChart, -1
}

updateChart() {
    global
    Gui Submit, NoHide
    Charter.debugmode := debugmode
    
    chart.datasets := [] ; 데이터 초기화
    loop % StrSplit(labels, ",").count()
        chart.data(data := gen(dataCount))
    
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
