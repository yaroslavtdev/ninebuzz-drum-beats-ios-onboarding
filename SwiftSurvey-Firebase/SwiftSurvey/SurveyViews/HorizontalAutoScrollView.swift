import SwiftUI

struct HorizontalAutoScrollView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var scrollViewWidth: CGFloat = 0

    var imageName: String
    var imageWidth: CGFloat = 1327
    var scrollDuration = 15.0

    var body: some View {
        GeometryReader { geometry in
            makeContentView()
                .onAppear {
                    self.scrollViewWidth = geometry.size.width
                    startAutoScroll()
                }
                .onChange(of: geometry.size.width) { newWidth in
                    self.scrollViewWidth = newWidth
                }
        }
    }

    @ViewBuilder
    func makeContentView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Image(uiImage: .lib_named(imageName))
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
            }
            .frame(width: imageWidth)
            .offset(x: -scrollOffset)
        }
        .disabled(true)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }

    func startAutoScroll() {
        withAnimation(Animation.linear(duration: scrollDuration)) {
            scrollOffset = imageWidth - scrollViewWidth
        }
    }
}
