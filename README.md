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



