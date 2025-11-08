import UIKit

class ViewController: UIViewController {
    override func viewDidAppear(_ animated:Bool) {
       super.viewDidAppear(true)
        
        guard let jsonUrl = Bundle.main.url(forResource: "survey", withExtension: "json") else {
            print("File not found in bundle")
            return
        }
        do {
            let loadedSurvey = try Survey.LoadFromFile(url: jsonUrl)
            showSurvey(survey: loadedSurvey)
        } catch {
            print("Error loading survey from file \(error)")
        }

   }
    
    func showSurvey(survey: Survey) {
     
        
        var surveyView : SurveyView = SurveyView(survey: survey)
        //_=surveyView.preferredColorScheme(.light)
        surveyView.delegate = self
        let vc = SurveyViewController(rootView: surveyView)
        vc.overrideUserInterfaceStyle = .light
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)
        
    }
}

extension ViewController : SurveyViewDelegate {
    func loadingScreenFinished(screenIdx: Int, totalQuestions: Int) {
        print("loadingScreenFinished screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func didFinishOnboarding(with survey: Survey, screenIdx: Int, totalQuestions: Int) {
        print("loadingScreenFinished screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
        print(survey.getSelectedInstrumentTag())
        print(survey.getMotivationJoinedTag())
        print(survey.getMotivationJoinedText())
    }
    
    func surveyIntroductionScreenPresented() {
        print("surveyIntroductionScreenPresented")
    }
    
    func surveyStarted() {
        print("surveyStarted")
    }

    func surveyPopRequested() {
        print("surveyPopRequested")
    }

    func dynamicInfoScreenPresented(screenIdx: Int, totalQuestions: Int) {
        print("dynamicInfoScreenPresented screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func dynamicInfoContinue(screenIdx: Int, totalQuestions: Int) {
        print("dynamicInfoContinue screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func spotScreenPresented(screenIdx: Int, totalQuestions: Int) {
        print("spotScreenPresented screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func spotScreenContinue(screenIdx: Int, totalQuestions: Int) {
        print("spotScreenContinue screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func stylesScreenPresented(screenIdx: Int, totalQuestions: Int) {
        print("stylesScreenPresented screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }
    
    func stylesScreenContinue(screenIdx: Int, totalQuestions: Int) {
        print("stylesScreenContinue screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }

    func yesNoScreenPresented(screenIdx: Int, totalQuestions: Int) {
        print("yesNoScreenPresented screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }

    func yesNoScreenContinue(option: String, screenIdx: Int, totalQuestions: Int) {
        print("yesNoContinue screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }

    func loadingScreenShown(screenIdx: Int, totalQuestions: Int) {
        print("loadingScreenShown screenIdx: \(screenIdx), totalQuestions: \(totalQuestions)")
    }

    func surveyQuestionView(
        _ question: any SurveyQuestionAndChoices,
        screenIdx: Int,
        questionIdx: Int,
        totalScreens: Int,
        totalQuestions: Int
    ) {
        print( "shown \(question.tag)" )
    }
    
    func surveyQuestionAnswered(
        _ question: any SurveyQuestionAndChoices,
        screenIdx: Int,
        questionIdx: Int,
        totalScreens: Int,
        totalQuestions: Int
    ) {
        if question.choices.first?.allowsCustomTextEntry == true {
            let answer = question.choices.map { $0.customTextEntry ?? "" }.joined(separator: ", ")
            print("Answer: \(answer)")
        } else {
            let answer = question.choices.filter { $0.selected }.map { $0.text }.joined(separator: ", ")
            print("Answer: \(answer)")
        }
    }
}
