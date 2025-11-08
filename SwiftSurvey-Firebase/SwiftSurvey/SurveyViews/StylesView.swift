import Foundation
import SwiftUI

struct StylesView: View {
    let model: InfoScreenModel
    let onMainCTA: () -> Void
    let onSecondaryCTA: (() -> Void)?
    
    var body: some View {
        VStack {

            Spacer()
                .frame(minHeight: 20)
            Text(model.title)
                .introHeaderFont()
                .injectedScreenHeaderStyle()
            Spacer()
                .frame(minHeight: 20)
            HorizontalAutoScrollView(imageName: model.topImageName)
                .frame(minHeight: 366)
                .frame(maxHeight: .infinity)
            Spacer()
                .frame(minHeight: 20)

            Text(model.message)
                .subtitleStylesFont()
                .injectedScreenSubtitleStyle()
                .padding(.horizontal)
            Spacer()
                .frame(minHeight: 20)



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
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.horizontal)
    }
    
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        let model = InfoScreenModel(
            topImageName: "scrolling_image",
            title: "“So many styles to choose from. I love it!”",
            message: "300,000 musicians choose to practice with Drum Beats+",
            ctaMain: "NEXT STEP",
            ctaSecondary: nil,
            footerText: nil)
        StylesView(model: model, onMainCTA: {}, onSecondaryCTA: {})
            .background(Color.black)
    }
}
