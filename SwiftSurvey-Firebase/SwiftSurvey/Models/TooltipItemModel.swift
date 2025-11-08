import Foundation

final class TooltipItemModel: Codable {
    let title: String
    let message: String
    let shownByTag: String?
    
    init(title: String, message: String, shownByTag: String? = nil) {
        self.title = title
        self.message = message
        self.shownByTag = shownByTag
    }
}
