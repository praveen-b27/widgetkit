//
//  CovidWidgetIntentTimelineProvider.swift
//  Covid19WidgetExtension
//
//  Created by pbhaskar on 21/08/20.
//

import WidgetKit
import UIKit

struct GlobalStatsIntentProvider: IntentTimelineProvider {
  typealias Intent = Covid19WidgetIntent
  typealias Entry = CovidEntry
  
  let service = Covid19APIService.shared
  
  func getCountry(for configuration: Covid19WidgetIntent) -> String {
    switch configuration.country {
    case .brazil:
      return "brazil"
    case .china:
      return "china"
    case .italy:
      return "italy"
    default:
      return "india"
    }
  }
  
  func placeholder(with: Context) -> CovidEntry {
    CovidEntry.stubs
  }
  
  func snapshot(for configuration: Covid19WidgetIntent, with context: Context, completion: @escaping (CovidEntry) -> ()) {
    if context.isPreview {
      completion(.stubs)
    } else {
      self.callApiService(for: getCountry(for: configuration)) { response in
        switch response {
        case .success(let entry):
          completion(entry)
        case .failure:
          completion(.stubs)
        }
      }
    }
  }
  
  func timeline(for configuration: Covid19WidgetIntent, with context: Context, completion: @escaping (Timeline<CovidEntry>) -> ()) {
    self.callApiService(for: getCountry(for: configuration)) { response in
      switch response {
      case .success(let entry):
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 60 * 3)))
        completion(timeline)
        
      case .failure:
        let entry = CovidEntry.stubs
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 1)))
        completion(timeline)
      }
    }
  }
  
  func callApiService(for param: String, completion: @escaping (Result<CovidEntry, Error>) -> ()) {
    service.getCountryTotalCount(countryId: param) { response in
      switch response {
      case .success(let dailyCase):
        let dailyData = DailyNewCases(totalData: dailyCase)

        if let latest = dailyCase.last {
          let entryData = CovidEntry(date: Date(), dailyNewCases: dailyData.newCases, country: param.uppercased(), countryTotalCase: latest)
          completion(.success(entryData))
        } else {
          completion(.failure(Covid19APIError.noData))
        }
      case .failure:
        completion(.failure(Covid19APIError.noData))
      }
    }
  }
}
