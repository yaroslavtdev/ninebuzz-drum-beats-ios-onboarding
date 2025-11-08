import Foundation

class MultipleItemsQuestion : ObservableObject, SurveyQuestionAndChoices {

    let title: String
    let subtitle: String?
    let uuid: UUID
    var choices : [MultipleChoiceResponse]
    var image: String?

    var required: Bool = false

    var allowsMultipleSelection = false

    var autoAdvanceOnChoice : Bool = true
    var tag: String
    let footerText: String?

    init(
        title:String,
        subtitle: String? = nil,
        answers: [MultipleChoiceResponse],
        multiSelect : Bool = false,
        autoAdvanceOnChoice : Bool = true,
        tag : String,
        footerText: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.uuid = UUID()
        self.choices = answers
        self.autoAdvanceOnChoice = autoAdvanceOnChoice
        self.tag = tag
        self.allowsMultipleSelection = multiSelect
        self.footerText = footerText
    }


    static func == (lhs: MultipleItemsQuestion, rhs: MultipleItemsQuestion) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
