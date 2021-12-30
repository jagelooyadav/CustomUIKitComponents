# CustomUIKit

Components are created below:

1- SettingsTableView - This is custom table view implmented table data source inside itself. Caller just needs to pass view model/controller which implments TableInfo.

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

