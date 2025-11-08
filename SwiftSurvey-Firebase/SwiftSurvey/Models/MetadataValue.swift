import Foundation

enum MetadataValue: Codable {
    case stringValue(String)
    case intValue(Int)
    case doubleValue(Double)

    func value() -> Any {
        switch self {
        case .stringValue(let string):
            return string
        case .intValue(let int):
            return int
        case .doubleValue(let double):
            return double
        }
    }

    init(from decoder: Decoder) throws {
        if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            self = .doubleValue(doubleValue)
        } else if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            self = .intValue(intValue)
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            self = .stringValue(stringValue)
        } else {
            throw DecodingError.typeMismatch(MetadataValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "The encoded value is not of an expected type"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .stringValue(let string):
            try container.encode(string)
        case .intValue(let int):
            try container.encode(int)
        case .doubleValue(let double):
            try container.encode(double)
        }
    }
}
