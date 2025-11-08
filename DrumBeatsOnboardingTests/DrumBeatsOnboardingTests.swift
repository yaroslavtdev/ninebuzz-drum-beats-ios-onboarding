import XCTest
@testable import DrumBeatsOnboarding

class InstrumentTests: XCTestCase {

    func testAllInstrumentFullscreenImagesLoadSuccessfully() {
        for instrument in OnboardingInstrument.allCases {
            for (type, landscape) in [
                (SpeedQuestionType.timing, false),
                (SpeedQuestionType.timing, true),
                (SpeedQuestionType.confidence, false),
                (SpeedQuestionType.confidence, true),
                (SpeedQuestionType.motivated, false),
                (SpeedQuestionType.motivated, true)
            ] {
                let imageName = instrument.getImageName(type, landscape: landscape)

                // Attempt to load UIImage and assert it doesn't cause a crash
                XCTAssertNoThrow(UIImage.lib_named(imageName), "Image \(imageName) for \(instrument.rawValue) should be available in resources.")
            }
        }
    }

    func testAllInstrumentImagesLoadSuccessfully() {
        for instrument in OnboardingInstrument.allCases {
            let imageName = instrument.imageNameInfo

            // Attempt to load UIImage and assert it doesn't cause a crash
            XCTAssertNoThrow(UIImage.lib_named(imageName), "Image \(imageName) for \(instrument.rawValue) should be available in resources.")
        }
    }
}

