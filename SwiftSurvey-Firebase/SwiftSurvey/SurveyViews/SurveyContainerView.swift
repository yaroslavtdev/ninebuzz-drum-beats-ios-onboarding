import Foundation
import SwiftUI

struct SurveyContainerView: View {
    enum Constants {
        static var minProgress = 0.04
    }
    @ObservedObject var survey: Survey
    @Binding var currentQuestion: Int
    @Binding var multipleSelectionMade: Bool

    @Binding var isMovingForward: Bool
    @State private var lastDidAppearIdx: Int?

    var onSurveyNext: (() -> Void)?
    var onSurveyBack: (() -> Void)?
    var onSurveyClose: (() -> Void)?
    var onDidAppearQuestion: ((_ question: any SurveyQuestionAndChoices, _ index: Int) -> Void)?
    var onDidAnswerQuestion: ((_ question: any SurveyQuestionAndChoices, _ index: Int) -> Void)?

    var transitionType: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: isMovingForward ? .trailing : .leading)
                .animation(.easeInOut(duration: 0.3)),
            removal: AnyTransition.move(edge: isMovingForward ? .leading : .trailing)
                .animation(.easeInOut(duration: 0.3))
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            makeNavigationView()
                .padding(.top, SurveyConstants.verticalPadding)
            let questions = survey.screens.compactMap { $0.question }
            ForEach(questions.indices, id: \.self) { i in
                if i == currentQuestion {
                    let baseQuestion = questions[currentQuestion]
                    GeometryReader { geometry in
                        makeMultipleItemsView(baseQuestion)
                            .onAppear {
                                handleOnAppear(for: baseQuestion, idx: currentQuestion)
                            }
                            .background(Color.black)
                            .frame(minHeight: geometry.size.height)
                    }
                    .transition(transitionType)
                }
            }
        }
        .background(Color.black)
        .ignoresSafeArea(edges: .horizontal)
        .transition(transitionType)
    }

    @ViewBuilder
    func makeNavigationView() -> some View {
        ZStack {
            HStack(alignment: .center) {
                Button(action: {
                    HapticManager.generateHapticFeedback(for: .selection)
                    if currentQuestion <= 0 {
                        onSurveyClose?()
                    } else {
                        onSurveyBack?()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .padding(.leading, 20)
                        .foregroundColor(Color(.lib_appGray))
                }
                Spacer()
            }
            let questions = survey.screens.compactMap { $0.question }
            SurveyProgressView(currentStep: $currentQuestion, totalSteps: questions.count)
                .padding(.horizontal, 65)
        }
    }

    @ViewBuilder
    func makeMultipleItemsView(_ question: MultipleItemsQuestion) -> some View {
        makeMultipleTextItemsView(question)
    }

    @ViewBuilder
    func makeMultipleTextItemsView(_ question: MultipleItemsQuestion) -> some View {
        MultipleItemsVerticalChoiceQuestionView(
            question: question,
            onChoiceStartAnimate: {  },
            onChoiceMade: {
                onDidAnswerQuestion?(question, currentQuestion)
                handleNextTapped()
            },
            onMultipleSelection: { isSelected in
                multipleSelectionMade = isSelected
            }
        )
    }

    func handleNextTapped() {
        onSurveyNext?()
    }

    func handleBackTapped() {
        onSurveyBack?()
    }

    private func handleOnAppear(for baseQuestion: any SurveyQuestionAndChoices, idx: Int) {
        if lastDidAppearIdx != idx {
            lastDidAppearIdx = idx
            onDidAppearQuestion?(baseQuestion, currentQuestion)
        }
    }
}
