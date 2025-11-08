import Foundation
import SwiftUI

struct PostOnboardingLoadingView: View {
    @ObservedObject var viewModel: PostOnboardingLoadingViewModel
    var onFinish: (() -> Void)?

    var body: some View {
        ZStack {
            Image(uiImage: .lib_named("bg_blue-red"))
                .resizable()
            VStack(spacing: 20) {

                CircularProgressTimerView(onCompletion: { onFinish?() }, totalLoadingTime: viewModel.model.durationSec)
        
                VStack(spacing: 50) {
                    Text(viewModel.model.infoTitle)
                        .loadingTitleFont()

                    VStack(spacing: 5) {
                        Text(viewModel.model.headerText)
                            .loadingHeaderFont()
                        Text(viewModel.model.subheadingText)
                            .loadingSubheadingFont()
                    }
                    VStack(spacing: 20) {
                        Image(uiImage: .lib_named(viewModel.model.topImageName))

                        Text("⭐⭐⭐⭐⭐")
                            .loadingStarsFont()
                        Text(viewModel.model.bottomText)
                            .loadingbottomTextFont()

                    }

                }

            }
            Spacer()
        }
        .ignoresSafeArea(.all)
    }
}


struct PostOnboardingLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let model = PostOnboardingLoadingModel(
            infoTitle: "Personalizing Your App...",
            headerText: "4.8 Top-Rated",
            subheadingText: "Music App",
            topImageName: "review_image",
            durationSec: 6,
            bottomText: "6.5k App Store Reviews"
        )

        let viewModel = PostOnboardingLoadingViewModel(model: model)
        PostOnboardingLoadingView(viewModel: viewModel)
            .background(.black)
    }
}
