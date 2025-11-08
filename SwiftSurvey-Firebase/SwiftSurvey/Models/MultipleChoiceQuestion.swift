import Foundation
import Combine

public class MultipleChoiceQuestion : ObservableObject, SurveyQuestionAndChoices {

    public let title : String
    public let uuid: UUID
    public var choices : [MultipleChoiceResponse]
    public var image: String?
    public var required: Bool = false
    public var allowsMultipleSelection = false
    public var tag: String

    init(
        title:String,
        answers:[MultipleChoiceResponse],
        multiSelect : Bool = false,
        tag : String,
        required : Bool = false
    ) {
        self.title = title
        self.uuid = UUID()
        self.choices = answers
        self.allowsMultipleSelection = multiSelect
        self.tag = tag
        self.required = required
    }

    public static func == (lhs: MultipleChoiceQuestion, rhs: MultipleChoiceQuestion) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

public class MultipleChoiceResponse : ObservableObject, Codable, Hashable {

    public let text : String
    public let subtitle : String?
    public let tag: String
    public var nextQuestionDiff: Int? = 1
    public let icon: String?
    let uuid : UUID
    public var selected = false

    public let allowsCustomTextEntry : Bool
    public var customTextEntry: String? = nil
    var tooltip: TooltipItemModel?

    init(_ text : String, subtitle: String? = nil, tag: String, icon: String? = nil, allowsCustomTextEntry: Bool = false,  tooltip: TooltipItemModel? = nil) {
        self.text = text
        self.subtitle = subtitle
        self.icon = icon
        self.tag = tag
        self.uuid = UUID()
        self.allowsCustomTextEntry = allowsCustomTextEntry
        self.tooltip = tooltip
    }

    // MARK: - Hashable
    public static func == (lhs: MultipleChoiceResponse, rhs: MultipleChoiceResponse) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
