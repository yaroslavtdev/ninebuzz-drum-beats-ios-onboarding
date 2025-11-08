import Foundation
import SwiftUI

struct LevelInfoView: View {
    let model: TooltipItemModel

    var body: some View {

        HStack(alignment: .top) {
            HStack {
                Image(uiImage: .lib_named("uptrend-circle-icon"))
                    .resizable()
                    .frame(width: 20, height: 20)

            }
            VStack(alignment: .leading, spacing: 10) {
                Text(model.title)
                    .titleFont()
                Text(model.message)
                    .subtitleFont()
                    .surveyInfoBoxStyle()

            }
            Spacer()
        }
        .padding(.all, 10)
        .background(Color(.lib_appPurple))
        .cornerRadius(4)

    }

}

struct LevelInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TooltipItemModel(title: "Title", message: "5% of our users* are just getting started.", shownByTag: "yes")
        LevelInfoView(model: model)
            .padding(.horizontal, 20)
    }
}
