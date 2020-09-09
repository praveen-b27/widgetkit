//
//  IntentHandler.swift
//  IntentHandler
//
//  Created by pbhaskar on 25/08/20.
//

import Intents

class IntentHandler: INExtension {
  let service = Covid19APIService.shared
  
  override func handler(for intent: INIntent) -> Any {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self
  }
}
extension IntentHandler: Covid19DynamicTypeIntentHandling {
  func provideCountryOptionsCollection(for intent: Covid19DynamicTypeIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<Country>?, Error?) -> Void) {
    
    service.getCountries { (response) in
      switch response {
      case .success(let countries):
        if let _ = searchTerm {
          let filteredData: [Country] = countries.filter { (eachCountry) -> Bool in
            if let id = eachCountry.identifier {
              return id.contains("india")
            }
            return false
          }
          let collection = INObjectCollection(items: filteredData)
          completion(collection, nil)
        } else {
          let collection = INObjectCollection(items: countries)
          completion(collection, nil)
        }
      case .failure:
        completion(nil, Covid19APIError.noData)
      }
    }
  }
  
  func defaultCountry(for intent: Covid19DynamicTypeIntent) -> Country? {
    return Country(identifier: "italy", display: "Italy")
  }
}
