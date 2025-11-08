import Foundation

public struct InfoScreenModel: Codable {
    let topImageName: String
    let title: String
    let message: String
    let author: String?
    let ctaMain: String
    let ctaSecondary: String?
    let footerText: String?
    let roundedCorners: Bool?

    public init(
        topImageName: String,
        title: String,
        message: String,
        author: String? = nil,
        ctaMain: String,
        ctaSecondary: String?,
        footerText: String?,
        roundedCorners: Bool = false
    ) {
        self.topImageName = topImageName
        self.title = title
        self.message = message
        self.ctaMain = ctaMain
        self.ctaSecondary = ctaSecondary
        self.footerText = footerText
        self.roundedCorners = roundedCorners
        self.author = author
    }
}
