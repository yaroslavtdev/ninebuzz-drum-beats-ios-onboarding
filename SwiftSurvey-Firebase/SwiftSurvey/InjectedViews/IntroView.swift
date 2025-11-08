import Foundation
import SwiftUI

struct IntroView: View {
    let model: InfoScreenModel
    let onMainCTA: () -> Void
    let onSecondaryCTA: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {

            Image(uiImage: .lib_named(model.topImageName))
                .resizable()
            Spacer()
            Spacer()
            VStack {
                VStack(spacing: 16) {
                    Text(model.title)
                        .introHeaderFont()
                        .introHeaderStyle()


                    Text(model.message)
                        .subtitleFont()
                        .injectedScreenSubtitleStyle()
                        .padding(.bottom, 22)
                }


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

        .background(.black)
        //  .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.top)
    }

}

struct InfoViewBigTitle_Previews: PreviewProvider {
    static var previews: some View {
        let model = InfoScreenModel(
            topImageName: "image_top_intro",
            title: "Let’s personalize your app!",
            message: "",
            ctaMain: "GET STARTED",
            ctaSecondary: nil,
            footerText: "")
        IntroView(model: model, onMainCTA: {}, onSecondaryCTA: {})
    }
}
