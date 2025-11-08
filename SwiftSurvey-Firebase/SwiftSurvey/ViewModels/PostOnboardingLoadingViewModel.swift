import Foundation
import SwiftUI

class PostOnboardingLoadingViewModel: ObservableObject {

    let model: PostOnboardingLoadingModel

    init(model: PostOnboardingLoadingModel) {
        self.model = model
    }
}
