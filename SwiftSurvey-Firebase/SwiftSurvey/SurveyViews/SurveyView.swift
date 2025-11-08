import SwiftUI
import Combine
public protocol SurveyViewDelegate : AnyObject {
    func surveyIntroductionScreenPresented()
    func surveyStarted()
    func surveyPopRequested()
    func surveyQuestionView(
        _ question: any SurveyQuestionAndChoices,
        screenIdx: Int,
        questionIdx: Int,
        totalScreens: Int,
        totalQuestions: Int
    )
    func surveyQuestionAnswered(
        _ question: any SurveyQuestionAndChoices,
        screenIdx: Int,
        questionIdx: Int,
        totalScreens: Int,
        totalQuestions: Int
    )
    func dynamicInfoScreenPresented(screenIdx: Int, totalQuestions: Int)
    func dynamicInfoContinue(screenIdx: Int, totalQuestions: Int)

    func spotScreenPresented(screenIdx: Int, totalQuestions: Int)
    func spotScreenContinue(screenIdx: Int, totalQuestions: Int)

    func stylesScreenPresented(screenIdx: Int, totalQuestions: Int)
    func stylesScreenContinue(screenIdx: Int, totalQuestions: Int)

    func loadingScreenShown(screenIdx: Int, totalQuestions: Int)
    func loadingScreenFinished(screenIdx: Int, totalQuestions: Int)

    func yesNoScreenPresented(screenIdx: Int, totalQuestions: Int)
    func yesNoScreenContinue(option: String, screenIdx: Int, totalQuestions: Int)

    func didFinishOnboarding(with survey: Survey, screenIdx: Int, totalQuestions: Int)
}

public class SurveyViewModel: ObservableObject {
    @ObservedObject var survey : Survey
    private var _surveyStageIdx: Int = 0

    var surveyStageIdx: Int {
        get { _surveyStageIdx }
        set {
            if _surveyStageIdx != newValue {
                updateSurveyStage(to: newValue)
            }
        }
    }
    @Published var isMovingForward: Bool = true
    @Published var surveyState: ScreenType = .intro
    @Published var currentQuestion : Int = 0

    var isLastScreen: Bool {
        surveyStageIdx >= survey.screens.count - 1
    }

    init(survey: Survey) {
        self.survey = survey
        if let type = self.survey.screens.first?.type {
            surveyState = type
        }
        if let beginWithStageIdx = survey.beginWithStageIdx {
            updateSurveyStage(to: beginWithStageIdx)
        }
    }

    private func updateSurveyStage(to newStageIdx: Int) {
        withAnimation {
            let oldStageIdx = _surveyStageIdx
            _surveyStageIdx = newStageIdx
            isMovingForward = oldStageIdx < newStageIdx

            guard newStageIdx < survey.screens.count else { return }
            let screen = survey.screens[newStageIdx]
            let newState = screen.type

            let allQuestions = survey.screens.compactMap { $0.question }
            let newQuestionIdx = allQuestions.firstIndex { $0.uuid == screen.question?.uuid }

            if newState != surveyState {
                surveyState = newState
            }
            if let idx = newQuestionIdx, currentQuestion != idx {
                currentQuestion = idx
            }
        }
    }
}

public struct SurveyView: View {

    @State var multipleSelectionMade = false // Hack to show next button when more than 1 item selected

    // This one was added later to fix the issues animation glitched because of multiple view redraws per 1 value change
    // Later all props should be moved to viewModel to make it clean
    @ObservedObject var viewModel: SurveyViewModel

    @State var processing = false
    // To avoid duplicate reporting
    @State private var lastDidAppearIdx: Int?
    @State private var finishedEventPosted = false

    public var delegate : SurveyViewDelegate?

    public init(survey: Survey, delegate : SurveyViewDelegate? = nil) {
        self.viewModel = SurveyViewModel(survey: survey)
        self.delegate = delegate
    }
    
    var transitionType: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: viewModel.isMovingForward ? .trailing : .leading)
                .combined(with: .scale(scale: 1.0).animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))),
            removal: AnyTransition.move(edge: viewModel.isMovingForward ? .leading : .trailing)
                .combined(with: .scale(scale: 1.0).animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)))
        )
    }

    public var body: some View {
        let totalScreens = viewModel.survey.screens.count
        let totalQuestions = viewModel.survey.screens.compactMap{ $0.question }.count

        switch viewModel.surveyState {
        case .intro:
            if let infoModel = viewModel.survey.screens[viewModel.surveyStageIdx].infoModel {
                IntroView(model: infoModel, onMainCTA: {
                    delegate?.surveyStarted()
                    handleNext()
                }, onSecondaryCTA: nil)
                .transition(transitionType)
                .onAppear {
                    delegate?.surveyIntroductionScreenPresented()
                    guard lastDidAppearIdx != viewModel.surveyStageIdx else { return }
                    lastDidAppearIdx = viewModel.surveyStageIdx
                }
            } else {
                Spacer()
            }

        case .question:
            GeometryReader { geometry in

                ZStack{
                    SurveyContainerView(survey: viewModel.survey,
                                        currentQuestion: $viewModel.currentQuestion,
                                        multipleSelectionMade: $multipleSelectionMade,
                                        isMovingForward: $viewModel.isMovingForward,
                                        onSurveyNext: handleSurveyQuestionNext,
                                        onSurveyBack: handleBack,
                                        onSurveyClose: { delegate?.surveyPopRequested() },
                                        onDidAppearQuestion: { question, idx in
                        delegate?.surveyQuestionView(
                            question,
                            screenIdx: viewModel.surveyStageIdx,
                            questionIdx: idx,
                            totalScreens: totalScreens,
                            totalQuestions: totalQuestions
                        )
                    },
                                        onDidAnswerQuestion: { question, idx in
                        delegate?.surveyQuestionAnswered(
                            question,
                            screenIdx: viewModel.surveyStageIdx,
                            questionIdx: idx,
                            totalScreens: totalScreens,
                            totalQuestions: totalQuestions
                        )

                    })
                    // Semi-transparent gradient panel
                    VStack {
                        Spacer()
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0), Color.black.opacity(1)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: geometry.safeAreaInsets.bottom)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                .background(Color.black)
                .transition(transitionType)
            }
            .transition(transitionType)

        case .info:
            if let infoModel = viewModel.survey.screens[viewModel.surveyStageIdx].infoModel {
                InfoView(
                    model: infoModel,
                    onMainCTA: {
                        delegate?.spotScreenContinue(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                        handleNext()
                    },
                    onSecondaryCTA: nil,
                    onSurveyBack: handleBack
                )
                .background(Color.black)
                .transition(transitionType)
                .onAppear {
                    guard lastDidAppearIdx != viewModel.surveyStageIdx else { return }
                    lastDidAppearIdx = viewModel.surveyStageIdx
                    delegate?.spotScreenPresented(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                }
            } else {
                Spacer()
            }
        case .styles:

            if let infoModel = viewModel.survey.screens[viewModel.surveyStageIdx].infoModel {
                StylesView(model: infoModel, onMainCTA: {
                    delegate?.stylesScreenContinue(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                    handleNext()
                }, onSecondaryCTA: nil)
                .background(Color.black)
                .transition(transitionType)
                .onAppear {
                    guard lastDidAppearIdx != viewModel.surveyStageIdx else { return }
                    lastDidAppearIdx = viewModel.surveyStageIdx
                    delegate?.stylesScreenPresented(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                }
            } else {
                Spacer()
            }

        case .dynamicInfo:
            if let selectedTag = viewModel.survey.getSelectedInstrumentTag(), let selectedIntrument = OnboardingInstrument(rawValue: selectedTag) {
                let quote = selectedIntrument.messageInfo
                let infoModel = InfoScreenModel(
                    topImageName: selectedIntrument.imageNameInfo,
                    title: selectedIntrument.headlineInfo,
                    message: quote,
                    author: ("-" + selectedIntrument.messageAuthor),
                    ctaMain: "NEXT STEP",
                    ctaSecondary: nil,
                    footerText: "⭐⭐⭐⭐⭐",
                    roundedCorners: true
                )
                InfoView(
                    model: infoModel,
                    onMainCTA: {
                        delegate?.dynamicInfoContinue(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                        handleNext()
                    },
                    onSecondaryCTA: nil,
                    onSurveyBack: handleBack
                )
                .background(Color.black)
                .transition(transitionType)
                .onAppear {
                    guard lastDidAppearIdx != viewModel.surveyStageIdx else { return }
                    lastDidAppearIdx = viewModel.surveyStageIdx
                    delegate?.dynamicInfoScreenPresented(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                }
            } else {
                Spacer()
            }

        case .loading:
            if let model = viewModel.survey.screens[viewModel.surveyStageIdx].postOnboardingLoadingModel {
                let viewModel = PostOnboardingLoadingViewModel(model: model)
                PostOnboardingLoadingView(viewModel: viewModel, onFinish: {
                    guard !finishedEventPosted else { return }
                    finishedEventPosted = true
                    delegate?.loadingScreenFinished(screenIdx: self.viewModel.surveyStageIdx, totalQuestions: totalScreens)
                    handleNext()
                })
                .transition(transitionType)
                .onAppear {
                    guard lastDidAppearIdx != self.viewModel.surveyStageIdx else { return }
                    lastDidAppearIdx = self.viewModel.surveyStageIdx
                    delegate?.loadingScreenShown(screenIdx: self.viewModel.surveyStageIdx, totalQuestions: totalScreens)
                }
            } else {
                Spacer()
            }
        case .quickQuestion:
                if let infoModel = viewModel.survey.screens[viewModel.surveyStageIdx].speedQModel,
                   let selectedTag = viewModel.survey.getSelectedInstrumentTag(), let selectedIntrument = OnboardingInstrument(rawValue: selectedTag) {
                    FullScreenInfoView(
                        model: infoModel,
                        instument: selectedIntrument,
                        onSurveyBack: handleBack,
                        onMainCTA: {
                            delegate?.yesNoScreenContinue(option: "Yes", screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                            handleNext()
                        }, onSecondaryCTA: {
                            delegate?.yesNoScreenContinue(option: "No", screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                            handleNext()
                        })
                    .id(viewModel.surveyStageIdx)
                    .background(Color.black)
                    .onAppear {
                        guard lastDidAppearIdx != viewModel.surveyStageIdx else { return }
                        lastDidAppearIdx = viewModel.surveyStageIdx
                        delegate?.yesNoScreenPresented(screenIdx: viewModel.surveyStageIdx, totalQuestions: totalScreens)
                    }
                    .transition(transitionType)
                } else {
                    Spacer()
                }
        }
    }
    // MARK: - Handlers

    func handleStart() {
        handleNext()
    }

    func handleNext() {
        guard !viewModel.isLastScreen else {
            delegate?.didFinishOnboarding(with: viewModel.survey, screenIdx: viewModel.surveyStageIdx, totalQuestions: viewModel.survey.screens.count)
            return
        }
        viewModel.surveyStageIdx += 1
    }

    func handleSurveyQuestionNext() {
        let questions = viewModel.survey.screens.compactMap { $0.question }
        let question = questions[viewModel.currentQuestion]
        var nextIdx: Int
        if !question.allowsMultipleSelection {
            nextIdx = viewModel.surveyStageIdx + (question.choices.first { $0.selected }?.nextQuestionDiff ?? 1)
        } else {
            nextIdx = viewModel.surveyStageIdx + 1
        }
        guard nextIdx < viewModel.survey.screens.count else  { return }

        viewModel.surveyStageIdx = nextIdx
    }

    func handleBack() {
        viewModel.surveyStageIdx -= 1
    }
}
