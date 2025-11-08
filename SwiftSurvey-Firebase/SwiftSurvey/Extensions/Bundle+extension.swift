import Foundation
import UIKit

public extension Bundle {
    static var resourceBundle: Bundle? {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: Survey.self)
#endif
    }
}


struct DeviceUtils {
    static var isSmallScreen: Bool {
        return UIScreen.main.bounds.height <= 667
    }
}
