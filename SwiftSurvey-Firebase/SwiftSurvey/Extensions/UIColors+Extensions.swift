import Foundation
import UIKit

public extension UIColor {

    static func lib_named(_ name: String) -> UIColor {
        guard let color = UIColor(named: name, in: .resourceBundle, compatibleWith: nil) else {
            fatalError("Failed to load color named \(name) from resources")
        }
        return color
    }
    static let lib_appTextDisabled: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_text_disabled", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()

    static let lib_appButtonBgDisabled: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_button_bg_disabled", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()

    static let lib_appProgress: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_progress_bg", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()

    static let lib_appAnswerBg: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_answer_bg", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()

    static let lib_appBlue: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_light_blue", in: .resourceBundle, compatibleWith: nil) ?? UIColor.green
    }()

    static let lib_appTextMain: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_text_main", in: .resourceBundle, compatibleWith: nil) ?? UIColor.white
    }()

    static let lib_appPurple: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_purple", in: .resourceBundle, compatibleWith: nil) ?? UIColor.purple
    }()

    static let lib_appGray: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_grey", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()

    static let lib_appButtonBg: UIColor = {
        let bundle = Bundle(for: Survey.self)
        return UIColor(named: "app_button_bg", in: .resourceBundle, compatibleWith: nil) ?? UIColor.darkGray
    }()
}
