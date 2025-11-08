import Foundation
import SwiftUI

public enum SurveyConstants {
    static var questionAnswerHeight: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 51.0 : 77.0
    }
    static var btnHeight: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 50.0 : 65.0
    }

    static var questionAnswerSpacing: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 16.0 : 20.0
    }
    static var horizontalPadding: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 10.0 : 10.0
    }
    static var verticalPadding: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 20.0 : 30.0
    }
    static var questionAnswerIconSize: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 17.0 : 25.0
    }
    static var fontMultiplier: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 1.0 : 1.66
    }
    static var progressCircleSize: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 134.0 : 164.0
    }
}

struct MainButtonStyle: ButtonStyle {
    let bgColor : Color
    let isDisabled: Bool

    init(bgColor: Color, isDisabled: Bool = false) {
        self.bgColor = bgColor
        self.isDisabled = isDisabled
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        let backgroundColor = isDisabled ? Color(.lib_appButtonBgDisabled) : bgColor
        return configuration.label
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .frame(minWidth: 200, maxWidth: 390, minHeight: SurveyConstants.btnHeight)
            .background(backgroundColor)
            .cornerRadius(50.0)
            .foregroundColor(Color.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .frame(maxWidth: 160, minHeight: SurveyConstants.btnHeight)
            .background(.black)
            .cornerRadius(50.0)
            .foregroundColor(Color.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct SurveyAnswerStyle: ButtonStyle {
    let selected : Bool
    init(selected: Bool) {
        self.selected = selected
    }
    func makeBody(configuration: Self.Configuration) -> some View {
        let bgColor = Color(.lib_appAnswerBg)
        let borderColor = selected ? Color.white : .clear
        let style = configuration.label
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
            .frame(minWidth: 200, minHeight: SurveyConstants.questionAnswerHeight)
            .background(bgColor)
            .cornerRadius(4.0)
            .foregroundColor(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4.0)
                    .stroke(borderColor, lineWidth: 2)
            )
        return style
    }
}
