import Foundation
import Combine

open class Survey : ObservableObject, Codable {

    @Published public var screens: [ScreenModel]

    public let version : String
    var metadata : [String: MetadataValue]? // debugging stuff
    public var beginWithStageIdx: Int? // custom idx to start with

    enum CodingKeys: CodingKey {
        case screens
        case version
        case metadata
    }
    
    public init(_ screens: [ScreenModel], version : String) {
        self.screens = screens
        self.version = version
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.screens = try container.decode([ScreenModel].self, forKey: .screens)
        self.version = try container.decode(String.self, forKey: .version)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(screens, forKey: .screens)
        try container.encode(version, forKey: .version)
        
        if let meta = self.metadata {
            try container.encode(meta, forKey: .metadata)
        }
    }
    
    open func getSelectedInstrumentTag() -> String? {
        let question = screens.compactMap { $0.question }.first { $0.tag.contains("instrument") }
        let selection = question?.choices.filter { $0.selected }
        guard let selection else { return nil }
        return selection.map { $0.tag }.joined(separator: "")
    }

    open func getSelectedInstrumentText() -> String? {
        let question = screens.compactMap { $0.question }.first { $0.tag.contains("instrument") }
        let selection = question?.choices.filter { $0.selected }
        guard let selection else { return nil }
        return selection.map { $0.text }.joined(separator: "")
    }

    open func getMotivationJoinedText() -> String {
        let question = screens.compactMap { $0.question }.first { $0.tag.contains("top-motivation") }
        let selection = question?.choices.filter { $0.selected }
        guard let selection else { return "" }
        return selection.map { $0.text }.joined(separator: ", ")
    }

    open func getMotivationJoinedTag() -> String {
        let question = screens.compactMap { $0.question }.first { $0.tag.contains("top-motivation") }
        let selection = question?.choices.filter { $0.selected }
        guard let selection else { return "" }
        return selection.map { $0.tag }.joined(separator: ", ")
    }
}
