import Foundation
import UIKit

public extension UIImage {
    static func lib_named(_ name: String) -> UIImage {
        guard let image = UIImage(named: name, in: .resourceBundle, compatibleWith: nil) else {
            fatalError("Failed to load image named \(name) from resources")
        }
        return image
    }

    static func lib_answerImage_named(_ selected: Bool, isMultiple: Bool) -> UIImage {
        let unselectedName = isMultiple ? "ic_answer_square" : "ic_answer_circle"
        let name = selected ? "\(unselectedName)_selected" : unselectedName
        guard let image = UIImage(named: name, in: .resourceBundle, compatibleWith: nil) else {
            fatalError("Failed to load image named \(name) from resources")
        }
        return image
    }

}
