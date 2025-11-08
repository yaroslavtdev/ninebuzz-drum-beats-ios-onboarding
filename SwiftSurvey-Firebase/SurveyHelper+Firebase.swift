import Foundation


public extension Survey {
    //MARK: - JSON
    static func getJsonStringFromData( jsonData: Data)->String? {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            
            //print("JSON OUTPUT")
            //print(jsonString)
            
            return jsonString
        }
        
        return nil
    }
    
    
    static func getJsonDataForSurvey(survey: Survey)->Data? {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(survey)

            return jsonData
            
            

            
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
    
    static func getSurveyFromString(jsonString: String) -> Survey? {
        do {
            
            let jsonData = jsonString.data(using: .utf8)!
            let survey = try JSONDecoder().decode(Survey.self, from: jsonData)
            return survey
            
        } catch {
            print(error)
        }
        
        return nil
    }
}
