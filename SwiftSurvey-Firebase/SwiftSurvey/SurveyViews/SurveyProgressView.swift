import Foundation
import SwiftUI

struct SurveyProgressView: View {
    @Binding var currentStep: Int
    let totalSteps: Int

    var body: some View {
        HStack(spacing: 0) {
            GeometryReader { geometry in
                let segmentWidth = (geometry.size.width / CGFloat(totalSteps))
                SegmentView()
                    .frame(width: segmentWidth * CGFloat(currentStep + 1))
            }
            Spacer()
        }
        .frame(height: 4)
        .background(Color(.lib_appProgress))
        .cornerRadius(2)
    }
}

struct SegmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(Color(.lib_appBlue))
            .frame(height: 4)
    }
}

struct SurveyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        @State var int: Int = 2
        SurveyProgressView(currentStep: $int, totalSteps: 5)
            .padding(.horizontal, 20)
    }
}
