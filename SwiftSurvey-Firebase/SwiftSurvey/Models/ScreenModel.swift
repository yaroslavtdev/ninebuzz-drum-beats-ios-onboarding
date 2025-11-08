import Foundation
import Combine

public final class ScreenModel: ObservableObject, Codable {
    let type: ScreenType
    @Published var question: MultipleItemsQuestion?
    var infoModel: InfoScreenModel?
    var speedQModel: SpeedQuestionScreenModel?
    var postOnboardingLoadingModel: PostOnboardingLoadingModel?

    enum CodingKeys: CodingKey {
        case type
        case question
        case metadata
    }
    
    init(type: ScreenType, question: MultipleItemsQuestion?) {
        self.type = type
        self.question = question
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(ScreenType.self, forKey: .type)
        self.question = try? container.decode(MultipleItemsQuestion.self, forKey: .question)
        self.infoModel = try? container.decode(InfoScreenModel.self, forKey: .metadata)
        self.speedQModel = try? container.decode(SpeedQuestionScreenModel.self, forKey: .metadata)
        self.postOnboardingLoadingModel = try? container.decode(PostOnboardingLoadingModel.self, forKey: .metadata)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let question {
            try container.encode(question, forKey: .question)
        }
        try container.encode(type, forKey: .type)
        if let info = self.infoModel {
            try container.encode(info, forKey: .metadata)
        }
        if let speedQModel = self.speedQModel {
            try container.encode(speedQModel, forKey: .metadata)
        }
        if let postOnboardingLoadingModel = postOnboardingLoadingModel {
            try container.encode(postOnboardingLoadingModel, forKey: .metadata)
        }
    }
}
