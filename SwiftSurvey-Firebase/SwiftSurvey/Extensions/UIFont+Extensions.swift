import Foundation
import UIKit

public extension UIFont {
    private static let interBoldFontName = "Inter-Bold"
    private static let interExtraBoldFontName = "Inter-ExtraBold"
    private static let interMediumFontName = "Inter-Medium"
    private static let interRegularFontName = "Inter-Regular"
    private static let interSemiBoldFontName = "Inter-SemiBold"
    private static let interItalicFontName = "Inter-Italic"

    static func loadFonts() {
        var bundle = Bundle.resourceBundle!
        var success = false
        let fontNames = [
            interItalicFontName,
            interBoldFontName,
            interExtraBoldFontName,
            interMediumFontName,
            interRegularFontName,
            interSemiBoldFontName
        ]
        for fontName in fontNames {
            if registerFont(bundle: bundle, fontName: fontName, fontExtension: ".ttf") == false {
                print("Failed to register font \(fontName)")
            } else {
                success = true
                print("Font did register successfully \(fontName)")
            }
        }
        guard !success else { return }

        // Fallback to get bundle from bundle file
        bundle = Bundle(url: bundle.url(forResource: String(describing: Survey.self), withExtension: "bundle")!)!
        for fontName in fontNames {
            if registerFont(bundle: bundle, fontName: fontName, fontExtension: ".ttf") == false {
                print("Failed to register font \(fontName)")
            } else {
                print("Font did register successfully \(fontName)")
            }
        }
    }

    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else { return false }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else { return false }
        guard let font = CGFont(fontDataProvider) else { return false }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else { return false }

        return true
    }

}
