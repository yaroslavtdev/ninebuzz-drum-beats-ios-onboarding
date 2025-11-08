import Foundation
import SwiftUI

struct MultipleItemsVerticalChoiceQuestionView : View {
    enum Constants {
        static var selectionDelay = 0.05
    }

    @State var selectedIndices: Set<Int> = []
    @ObservedObject var question: MultipleItemsQuestion
    @State private var isLandscape: Bool

    let onChoiceStartAnimate : (() -> Void)?
    let onChoiceMade : (() -> Void)?
    let onMultipleSelection : ((Bool) -> Void)?


    @State private var goingToNext : Bool = true

    init(
        question: MultipleItemsQuestion,
        onChoiceStartAnimate: ( () -> Void)?,
        onChoiceMade: ( () -> Void)?,
        onMultipleSelection: ( (Bool) -> Void)?
    ) {
        self.question = question
        self.onChoiceStartAnimate = onChoiceStartAnimate
        self.onChoiceMade = onChoiceMade
        self.onMultipleSelection = onMultipleSelection
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            self.isLandscape = false
            return }
        self.isLandscape = scene.interfaceOrientation.isLandscape
    }

    var body : some View {
        makeContentView()
            .frame(maxWidth: .infinity)
            .onAppear(perform: {
                self.updateChoices()

            })
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                self.isLandscape = scene.interfaceOrientation.isLandscape
            }

    }

    @ViewBuilder
    func makeContentView() -> some View {
        if isLandscape {
            GeometryReader { geometry in
                VStack(spacing: SurveyConstants.verticalPadding) {
                    Spacer()
                        .frame(maxHeight: SurveyConstants.verticalPadding)
                    HStack {
                        Spacer()
                            .frame(maxWidth: SurveyConstants.horizontalPadding)
                        VStack(spacing: 10) {
                            Text(question.title)
                                .surveyQuestionTitleFont()
                                .surveyQuestionStyle()
                            if let subtitle = question.subtitle {
                                Text(subtitle)
                                    .surveyQuestionSubtitleFont()
                                    .surveyQuestionStyle()
                            }
                        }
                        .frame(maxWidth: .infinity)

                        makeTextItemsView()
                            .frame(width: geometry.size.width/2)
                        Spacer()
                            .frame(maxWidth: SurveyConstants.horizontalPadding)

                    }
                    makeButtonView()

                }
            }
        } else {
            VStack(spacing: 0) {
                Spacer()
                    .frame(maxHeight: SurveyConstants.verticalPadding)
                VStack(spacing: 10) {
                    Text(question.title)
                        .surveyQuestionTitleFont()
                        .surveyQuestionStyle()
                    if let subtitle = question.subtitle {
                        Text(subtitle)
                            .surveyQuestionSubtitleFont()
                            .surveyQuestionStyle()
                    }
                }
                Spacer()
                    .frame(maxHeight: SurveyConstants.verticalPadding)
                makeTextItemsView()
                Spacer()

                makeButtonView()
            }
        }
    }

    @ViewBuilder
    func makeTextItemsView() -> some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 10.0) {
                    VStack(spacing: SurveyConstants.questionAnswerSpacing) {
                        ForEach(Array(question.choices.enumerated()), id: \.element) { index, choice in
                            VStack(spacing: SurveyConstants.questionAnswerSpacing) {
                                let isSelected = selectedIndices.contains(index)
                                let style = SurveyAnswerStyle(selected: isSelected)
                                Button(action: { selectChoice(index) }, label: {
                                    HStack {
                                        Image(uiImage: .lib_answerImage_named(isSelected, isMultiple: question.allowsMultipleSelection ))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: SurveyConstants.questionAnswerIconSize, height: SurveyConstants.questionAnswerIconSize)
                                        Text(choice.text)
                                            .answerFont(selected: isSelected)
                                            .surveyAnswerStyle()
                                    }
                                    .padding(.horizontal, SurveyConstants.horizontalPadding)
                                })
                                .buttonStyle(style)
                                if isSelected, let tooltip =  choice.tooltip {
                                    LevelInfoView(model: TooltipItemModel(title: tooltip.title, message: tooltip.message))

                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, SurveyConstants.questionAnswerHeight/2)
            }
            LinearGradient(
                           gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.5)]),
                           startPoint: .top,
                           endPoint: .bottom
                       )
            .frame(height: SurveyConstants.questionAnswerHeight/2) // Adjust height as needed
                       .edgesIgnoringSafeArea(.bottom)
        }
    }

    @ViewBuilder
    func makeButtonView() -> some View {
        VStack(spacing: 20) {
            if let footerText = question.footerText, !selectedIndices.isEmpty {
                Text(footerText)
                    .footerFont()
            }
            if question.allowsMultipleSelection || !question.autoAdvanceOnChoice {
                let disabled = !question.autoAdvanceOnChoice && selectedIndices.isEmpty
                let style = MainButtonStyle(bgColor: Color(.lib_appBlue), isDisabled: disabled)
                Button(action: {
                    guard !disabled else { return }
                    onContinue()
                }, label: {
                    Text("Continue")
                        .mainButtonFont(isDisabled: disabled)
                        .mainButtonStyle()
                        .frame(maxWidth: .infinity)
                        .padding(15)
                })
                .buttonStyle(style)
                .padding(.leading, 24)
                .padding(.trailing, 24)
                .padding(.bottom, 22)
            }
        }
    }

    // Update the local @State with selected choice
    func updateChoices() {
        selectedIndices = []
        for (i,choice) in question.choices.enumerated() {
            if choice.selected {
                selectedIndices.insert(i)
            }
        }
    }

    func selectChoice( _ choiceIndex: Int ) {
        let selectedChoice = question.choices[choiceIndex]
        HapticManager.generateHapticFeedback(for: .selection)
        if question.allowsMultipleSelection {
            withAnimation(.none) {
                for (i,choice) in question.choices.enumerated() {
                    if selectedChoice.uuid == choice.uuid {
                        if selectedIndices.contains(i) {
                            selectedIndices.remove(i)
                            question.choices[i].selected = false;
                            selectedChoice.selected = false;
                        } else {
                            selectedIndices.insert(i)
                            question.choices[i].selected = true;
                            selectedChoice.selected = true;
                        }
                    }
                }
            }
            onMultipleSelection?(selectedIndices.count > 0)
        } else {
            withAnimation(.none) {
                selectedIndices = []
                selectedIndices.insert(choiceIndex)
                //question.choices[choiceIndex].selected = true;
                for (i,choice) in question.choices.enumerated() {
                    choice.selected = i == choiceIndex
                    question.choices[i].selected = choice.selected
                }
            }
            handleChoice()
        }
    }

    func handleChoice() {
        HapticManager.generateHapticFeedback(for: .selection)
        if question.autoAdvanceOnChoice {
            goNext()
        }
    }

    func onContinue() {
        HapticManager.generateHapticFeedback(for: .selection)
        goNext()
    }

    func goNext() {
        self.goingToNext = true

        onChoiceStartAnimate?()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.selectionDelay) {
            self.onChoiceMade?()
        }
    }
}

struct MultipleItems_Previews: PreviewProvider {

    static var previews: some View {
        let answers = [
            MultipleChoiceResponse("0", tag: "", tooltip: TooltipItemModel(title: "Test", message: "5% of our users* are just getting started.")),
            MultipleChoiceResponse("1", tag: "", tooltip: TooltipItemModel(title: "Test2", message: "25% of our users* are building their foundation, just like you.")),
            MultipleChoiceResponse("2", tag: "", tooltip: TooltipItemModel(title: "Test3", message: "Test description")),
            MultipleChoiceResponse("3", tag: "", tooltip: TooltipItemModel(title: "Test4", message: "Test description")),
            MultipleChoiceResponse("4", tag: "", tooltip: TooltipItemModel(title: "Test5", message: "Test description"))
        ]

        let question = MultipleItemsQuestion(
            title: "What’s your experience level?",
            answers: answers,
            multiSelect: false,
            autoAdvanceOnChoice: false,
            tag: "how-long-waping",
            footerText: "*users of Drum Beats+ who took the quiz.")

        MultipleItemsVerticalChoiceQuestionView(question: question,
                                                onChoiceStartAnimate: {},
                                                onChoiceMade: {},
                                                onMultipleSelection: {_ in })
        .background(.black)
    }
}
