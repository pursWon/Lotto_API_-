import UIKit

struct Theme: Equatable {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)

    enum `Type` {
        case light
        case dark
    }
    
    let type: Type
    
    let backgroundColor: UIColor
    let textColor: UIColor
    let descriptionTextColor: UIColor
    let separatorColor: UIColor
    let tableViewBackground: UIColor
    let navbarTintColor: UIColor
    let navbarStyle: UIBarStyle
    let switchTintColor: UIColor

    init(type: Type, colors: ColorPalette) {
        self.type = type
        self.backgroundColor = colors.background
        self.textColor = colors.foreground
        self.descriptionTextColor = colors.secondary
        self.separatorColor = colors.secondary
        self.tableViewBackground = colors.secondaryBackground
        self.navbarTintColor = colors.tint
        self.navbarStyle = type == .dark ? .black : .default
        self.switchTintColor = colors.tint
    }

    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.type == rhs.type
    }
}

