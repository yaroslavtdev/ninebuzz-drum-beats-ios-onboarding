import Foundation
import SwiftUI

import SwiftUI

struct CircularProgressTimerView: View {
    @State private var progress: CGFloat = 0.0
    @State private var invocationCount: Int = 0
    var onCompletion: () -> Void
    let totalLoadingTime: Double

    private var timerInterval: Double {
        totalLoadingTime / 100
    }

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(Color(UIColor.lib_appBlue))
                .frame(width: SurveyConstants.progressCircleSize, height: SurveyConstants.progressCircleSize)

            // Progress circle
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(UIColor.lib_appBlue))
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
                .frame(width: SurveyConstants.progressCircleSize, height: SurveyConstants.progressCircleSize)

            // Percentage text
            Text(String(format: "%.0f%%", min(progress, 1.0) * 100.0))
                .progressFont()
                .foregroundColor(.white)
        }

        .onAppear {
            startTimer()
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { timer in
            if progress < 1.0 {
                invocationCount += 1
                if invocationCount % 10 == 0 {
                    HapticManager.generateHapticFeedback(for: .impact(.light))
                }
                progress += 0.01
            } else {
                timer.invalidate() // Stop the timer
                onCompletion() // Call the completion closure
                HapticManager.generateHapticFeedback(for: .impact(.heavy))
            }
        }
    }
}

struct LineProgressTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressTimerView(onCompletion: {
            print("Completed")
        }, totalLoadingTime: 6.0)
        .background(.black)
    }
}
