import Foundation
import SwiftUI

struct InfoView: View {
    let model: InfoScreenModel
    let onMainCTA: () -> Void
    let onSurveyBack: (() -> Void)?
    let onSecondaryCTA: (() -> Void)?
    @State private var isLandscape: Bool

    init(
        model: InfoScreenModel,
        onMainCTA: @escaping () -> Void,
        onSecondaryCTA: ( () -> Void)?,
        onSurveyBack: (() -> Void)? = nil
    ) {
        self.model = model
        self.onMainCTA = onMainCTA
        self.onSecondaryCTA = onSecondaryCTA
        self.onSurveyBack = onSurveyBack
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            self.isLandscape = false
            return }
        self.isLandscape = scene.interfaceOrientation.isLandscape
    }

    var body: some View {
        VStack(spacing: 0) {
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
            makeContentView()
                .frame(maxWidth: .infinity)
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    self.isLandscape = scene.interfaceOrientation.isLandscape
                }
        }
    }
    
    @ViewBuilder
    func makeBody() -> some View {
        if model.author == nil {
            Spacer()
                .frame(maxHeight: SurveyConstants.verticalPadding/2)
        }
        Image(uiImage: .lib_named(model.topImageName))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(model.roundedCorners == true ? 15 : 0)
            .padding(.horizontal)

        VStack(spacing: 20) {
            if let author = model.author {
                Text(model.message)
                    .subtitleInfoItalicFont()
                    .injectedScreenSubtitleStyle()
                Text(author)
                    .subtitleInfoFont()
                    .injectedScreenSubtitleStyle()
            } else {
                Text(model.message)
                    .subtitleInfoFont()
                    .injectedScreenSubtitleStyle()
            }

            if let footerText = model.footerText {
                Text(footerText)
                    .subtitleInfoFont()
                    .injectedScreenSubtitleStyle()
            }
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder
    func makeContentView() -> some View {

        VStack(spacing: SurveyConstants.verticalPadding) {
            Text(model.title)
                .introHeaderFont()
                .injectedScreenHeaderStyle()

            if isLandscape {
                Spacer()
                HStack {
                    makeBody()
                }
            } else {
                VStack(alignment: .center, spacing: 30) {
                    makeBody()
                }
            }
            Spacer()

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
                        onSecondaryCTA?()
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
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = InfoScreenModel(
            topImageName: "image_top_right_spot",
            title: "You’re In The Right Spot!",
            message: "83% of musicians say they’d be disappointed if they could no longer practice with Drum Beats+",
            ctaMain: "Continue",
            ctaSecondary: nil,
            footerText: nil,
            roundedCorners: true)
        InfoView(model: model, onMainCTA: {}, onSecondaryCTA: {})
            .background(Color.black)
    }
}
