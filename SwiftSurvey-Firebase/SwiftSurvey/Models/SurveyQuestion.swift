import Foundation

public protocol SurveyQuestion : Codable, Equatable, Identifiable {
    var title : String { get }
    var uuid : UUID { get }
    var tag : String { get }
    var image: String? { get }
    var required : Bool { get set }
}

public protocol SurveyQuestionAndChoices: SurveyQuestion {
    var choices : [MultipleChoiceResponse] { get }
}
