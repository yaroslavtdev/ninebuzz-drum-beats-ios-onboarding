import Foundation

public struct SpeedQuestionScreenModel: Codable {
    let type: String
    let title: String
    let ctaMain: String
    let ctaSecondary: String?

    public init(
        type: String,
        title: String,
        ctaMain: String,
        ctaSecondary: String?
    ) {
        self.type = type
        self.title = title
        self.ctaMain = ctaMain
        self.ctaSecondary = ctaSecondary
    }
}

public enum SpeedQuestionType: String {
    case timing
    case confidence
    case motivated
}
