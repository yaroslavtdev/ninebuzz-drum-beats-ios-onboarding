import Foundation

import SwiftUI

extension Text {
    func introHeaderFont() -> Text {
        self.font(.custom("Inter-Bold", size: 24 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
            .tracking(tracking(for: 24 * SurveyConstants.fontMultiplier, percentage: -2))
    }

    func secondaryButtonFont() -> Text {
        self.font(.custom("Inter-SemiBold", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func mainButtonFont(isDisabled: Bool = false) -> Text {
        self.font(.custom("Inter-SemiBold", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(isDisabled ? Color(.lib_appTextDisabled) : .white)
    }

    func titleFont() -> Text {
        self.font(.custom("Inter-Bold", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
            .tracking(tracking(for: 24 * SurveyConstants.fontMultiplier, percentage: -2))
    }


    func subtitleFont() -> Text {
        self.font(.custom("Inter-Medium", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func subtitleInfoFont() -> Text {
        self.font(.custom("Inter-Regular", size: 18 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func subtitleInfoItalicFont() -> Text {
        self.font(.custom("Inter-Italic", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func subtitleStylesFont() -> Text {
        self.font(.custom("Inter-Medium", size: 20 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func answerFont(selected: Bool) -> Text {
        self.font(.custom("Inter-Medium", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(selected ? Color(.lib_appTextMain) : Color(.lib_appTextDisabled))
    }

    func footerFont() -> Text {
        self.font(.custom("Inter-Medium", size: 14 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func surveyQuestionTitleFont() -> Text {
        self.font(.custom("Inter-Bold", size: 24 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
            .tracking(tracking(for: 24 * SurveyConstants.fontMultiplier, percentage: -2))
    }

    func surveyQuestionSubtitleFont() -> Text {
        self.font(.custom("Inter-Regular", size: 13 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func progressFont() -> Text {
        self.font(.custom("Inter-Bold", size: 32 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func loadingTitleFont() -> Text {
        self.font(.custom("Inter-Medium", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
            .tracking(tracking(for: 16 * SurveyConstants.fontMultiplier, percentage: -2))
    }

    func loadingHeaderFont() -> Text {
        self.font(.custom("Inter-Bold", size: 40 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func loadingStarsFont() -> Text {
        self.font(.custom("Inter-SemiBold", size: 36 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func loadingbottomTextFont() -> Text {
        self.font(.custom("Inter-SemiBold", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }

    func loadingSubheadingFont() -> Text {
        self.font(.custom("Inter-Medium", size: 16 * SurveyConstants.fontMultiplier))
            .foregroundColor(Color(.lib_appTextMain))
    }
}


extension View {
    func introHeaderStyle() -> some View {
        self.lineSpacing(31.2 - 24)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    func introSubtitleStyle() -> some View {
        self.lineSpacing(20.8 - 16)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    func injectedScreenHeaderStyle() -> some View {
        self.lineSpacing(26 - 20)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    func injectedScreenSubtitleStyle() -> some View {
        self.lineSpacing(19.5 - 16)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    func surveyQuestionStyle() -> some View {
        self.lineSpacing(29.26 - 24)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    func surveyAnswerStyle() -> some View {
        self.lineSpacing(22 - 16)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }

    func surveyInfoBoxStyle() -> some View {
        self.lineSpacing(17.07 - 14)
            .multilineTextAlignment(.leading)
    }

    func mainButtonStyle() -> some View {
        self.lineSpacing(24.38 - 20)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }

    // Helper function to calculate tracking in points based on font size
    func tracking(for fontSize: CGFloat, percentage: CGFloat) -> CGFloat {
        // Calculate tracking based on percentage of font size
        return fontSize * (percentage / 100)
    }
}
