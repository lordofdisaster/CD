import Foundation
import UIKit

enum SocialType: String {
    case facebook = "FACEBOOK"
    case google = "GOOGLE"
}

struct Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

struct System {
    static let keyboardHeight = 216
    static let navigationBarHeight = 44
    static let statusBarHeight = 20
    static let tabBarHeight = 56
    static let switchNativeSize = (width: 51, height: 31)
}

struct Global {
    static let googleMapsAPIKey = "AIzaSyDQhsX3zXjZuDa18T5tbliDOQfR2_lIi24"
}

struct Color {
    static let darkBlue = #colorLiteral(red: 0.07058823529, green: 0.5137254902, blue: 0.9098039216, alpha: 1)
    static let blue = #colorLiteral(red: 0.2549019608, green: 0.6117647059, blue: 0.9294117647, alpha: 1)
    static let backgroundBlue = #colorLiteral(red: 0.8941176471, green: 0.9294117647, blue: 0.9607843137, alpha: 1)
    static let lightBlue = UIColor(red: 210.0/255.0, green: 231.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    static let yellow = #colorLiteral(red: 0.9607843137, green: 0.9254901961, blue: 0.5882352941, alpha: 1)
    static let backgroundLightBlue = #colorLiteral(red: 0.5725490196, green: 0.7490196078, blue: 0.9098039216, alpha: 1)
    static let grayText = #colorLiteral(red: 0.2078431373, green: 0.2156862745, blue: 0.2235294118, alpha: 1)
    static let lightGrayText = #colorLiteral(red: 0.4784313725, green: 0.5294117647, blue: 0.5803921569, alpha: 1)
    static let lightGray = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
    static let darkGray = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    static let green = #colorLiteral(red: 0.09803921569, green: 0.7254901961, blue: 0.6784313725, alpha: 1)
}


