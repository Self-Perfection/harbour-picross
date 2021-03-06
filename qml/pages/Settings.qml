import QtQuick 2.0
import Sailfish.Silica 1.0
import "../DB.js" as DB

Page{
    id: settingsPage
    RemorsePopup{ id: remorseSettings }
    Column{
        width: parent.width
        PageHeader{
            title: "Settings"
        }
        TextSwitch{
            checked: DB.getParameter("autoLoadSave")===1
            text: "Load saves by default"
            description: checked?"Saves will be loaded by default":"Load them by a long press"
            onClicked:{
                if(checked)
                    DB.setParameter("autoLoadSave", 1)
                else
                    DB.setParameter("autoLoadSave", 0)
            }
        }
        TextSwitch{
            checked: DB.getParameter("slideInteractive")===1
            text: "Swipe throught difficulty"
            description: checked?"Swipe is enabled":"Swipe disable. Click on a difficulty name to load it"
            onClicked:{
                if(checked)
                    DB.setParameter("slideInteractive", 1)
                else
                    DB.setParameter("slideInteractive", 0)
            }
        }
        Slider {
            id: slider
            width: parent.width
            label: "Space between separators"
            minimumValue: 0
            maximumValue: 10
            stepSize: 1
            value: DB.getParameter("space")
            valueText: value
            onValueChanged: {
                game.space = slider.value
                DB.setParameter("space", slider.value)
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Clear ALL databases (saves & progress)"

            onClicked:{
                remorseSettings.execute("Clearing ALL Databases", function(){
                    DB.destroyData()
                    DB.initialize()})
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Clear only saves database"
            onClicked:{
                remorseSettings.execute("Clearing only saves database", function(){
                    DB.destroySaves()
                    DB.initializeSaves()})
            }
        }
        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Reset settings"
            onClicked:{
                remorseSettings.execute("Resetting settings", function(){
                    DB.destroySettings()
                    pageStack.pop()
                })
            }
        }
    }
    Component.onDestruction:{
        game.pause=false
    }
}
