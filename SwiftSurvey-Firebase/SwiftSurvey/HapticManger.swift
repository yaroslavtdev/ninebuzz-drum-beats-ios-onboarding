import Foundation
import UIKit
public enum HapticFeedback {

    // MARK: - Cases
    
    case selection
    case impact(UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(UINotificationFeedbackGenerator.FeedbackType)
}

public struct HapticManager {
    public static func generateHapticFeedback(for hapticFeedback: HapticFeedback) {
        switch hapticFeedback {
        case .selection:
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
        case .impact(let feedbackStyle):
            let feedbackGenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
            feedbackGenerator.impactOccurred()
            
        case .notification(let feedbackType):
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.notificationOccurred(feedbackType)
        }
    }
}
