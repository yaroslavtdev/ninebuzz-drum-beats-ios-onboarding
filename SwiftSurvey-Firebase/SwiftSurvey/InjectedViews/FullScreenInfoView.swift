import Foundation
import SwiftUI

struct FullScreenInfoView: View {
    let model: SpeedQuestionScreenModel
    let instument: OnboardingInstrument
    var onSurveyBack: (() -> Void)?
    let onMainCTA: () -> Void
    let onSecondaryCTA: (() -> Void)?
    
    var body: some View {
            VStack(spacing: 30) {
                HStack(alignment: .center) {
                    Button(action: {
                        HapticManager.generateHapticFeedback(for: .selection)
                        onSurveyBack?()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding(.leading, 20)
                            .foregroundColor(Color(.lib_appGray))
                    }
                    .opacity(1)

                    Spacer()
                }
                .padding(.top, SurveyConstants.verticalPadding)
                Spacer()
                Spacer()

                Text(model.title)
                    .introHeaderFont()


                if let secondaryCTA = model.ctaSecondary {
                    HStack(spacing: 28){
                        Button(action: {
                            HapticManager.generateHapticFeedback(for: .selection)
                            onSecondaryCTA?()
                        }, label: {
                            Text(secondaryCTA)
                                .secondaryButtonFont()
                                .mainButtonStyle()
                        })
                        .buttonStyle(SecondaryButtonStyle())

                        Button(action: {
                            HapticManager.generateHapticFeedback(for: .selection)
                            onMainCTA()
                        }, label: {
                            Text(model.ctaMain)
                                .mainButtonFont()
                                .mainButtonStyle()
                                .frame(maxWidth: .infinity)
                        })
                        .buttonStyle(MainButtonStyle(bgColor: Color(UIColor.lib_appBlue)))
                    }
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.bottom, 22)
                } else {
                    Button(action: {
                        HapticManager.generateHapticFeedback(for: .selection)
                        onMainCTA()
                    }, label: {
                        Text(model.ctaMain)
                            .mainButtonFont()
                            .mainButtonStyle()
                            .frame(maxWidth: .infinity)
                            .padding(15)
                    })
                    .buttonStyle(MainButtonStyle(bgColor: Color(UIColor.lib_appBlue)))
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
                    .padding(.bottom, 22)
                }

            }
            .padding(.all)
            .background {
                GeometryReader { geometry in
                    ZStack {
                        let isLandscape = geometry.size.width > geometry.size.height
                        Image(uiImage: .lib_named(instument.getImageName(SpeedQuestionType(rawValue: model.type) ?? .confidence, landscape: isLandscape)))
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                            .clipped()
                        VStack {
                            Spacer()
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.6)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height:  geometry.size.height / 2)
                            .frame(maxWidth: .infinity, alignment: .bottom)
                        }
                    }
                }
                .ignoresSafeArea(.all)
            }

    }

}

struct FullScreenInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = SpeedQuestionScreenModel(type: "timing", title: "Do you want to stay motivated and have fun while practicing?", ctaMain: "YES", ctaSecondary: "NO")
        FullScreenInfoView(model: model, instument: .accordion, onMainCTA: {}, onSecondaryCTA: {})
            .background(Color.black)
    }
}
