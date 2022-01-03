# CustomUIKit

Components are created below:

# SettingsTableView
This is custom table view implmented table data source inside itself. Caller just needs to pass view model/controller which implments TableInfo.

For example. To show image like below

<img width="290" alt="Setting table" src="https://user-images.githubusercontent.com/2247603/147758316-9ae67791-b28c-4bea-8e0b-7d732dd66d39.png">

From caller end below code needs to write.
let table = SettingsTableView(withTableInfo: tableDataSource)

where data source would be like below

```
class SettingsTableView: TableInfo {

 var cornerRadius: CGFloat {
        return 20.0
    }
    
    var icons: [UIImage] {
        return [UIImage(named: "icon_bluetooth")!, UIImage(named: "icon_wifi")!, UIImage(named: "icon_location")!, UIImage(named: "icon_camera")!]
    }
    
    var titles: [String] {
        return ["Bluetooth", "Wifi", "Location", "Camera"]
    }
    
    var textFont: UIFont? {
        return UIFont.subSFHeading
    }
    
    var cellTypes: [CellType] {
        return [.checkMark, .checkMark, .checkMark, .checkMark]
    }
}
```

# HeadingWithSeperator
Componets has put label and divider horizontaly.

For exoample below code will display heading like below
```
let headingWithSeperator = HeadingWithSeperator()
headingWithSeperator.title = "Some heading text"
headingWithSeperator.textColor = .green
```
<img width="274" alt="HeadingWithSeperator" src="https://user-images.githubusercontent.com/2247603/147768377-3c32385b-8889-40f4-b9fa-8f7625c9dcfe.png">

# PrgressBarButton
Customise UIButton view to add progress funtionality
Sample code
```
let button = ProgressBarButton()
button.primaryColor = .red
button.progressValueLabel = "Progress: 70 %"
button.progress = 0.70
```
<img width="485" alt="Progress bar button" src="https://user-images.githubusercontent.com/2247603/147928727-7801bf04-6b3f-456f-b913-0f910cd01a6b.png">

# Multi Choice question view
Created components for qustion view with multiple choice or objective type question view with custom font/color/theme view

```
let question3 = Question(title: "Why should you use custom ui component instead making fresh every time?",
                                                                        options: ["It will decrease code lines in project",
                                                                                  "It will reduce time in development",
                                                                                  "It increase time in development",
                                                                                  "It will reduce time in development"])
let questionView3 = ObjectiveQestionView(question: question3)
questionView3.questionTintColor = .green
questionView3.isMultipleSelection = true
```
<img width="490" alt="Question View" src="https://user-images.githubusercontent.com/2247603/147929100-0503c98e-8f47-49f9-8abd-f6d984d73f4d.png">



