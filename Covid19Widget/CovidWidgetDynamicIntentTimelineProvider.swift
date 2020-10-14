//
//  CovidWidgetDynamicIntentTimelineProvider.swift
//  Covid19WidgetExtension
//
//  Created by pbhaskar on 25/08/20.
//

import Foundation
import WidgetKit
import UIKit

struct GlobalStatsDynamicIntentProvider: IntentTimelineProvider {
  
  typealias Intent = Covid19DynamicTypeIntent
  typealias Entry = CovidEntry
  
  let service = Covid19APIService.shared
  
  func placeholder(in with: Context) -> CovidEntry {
    CovidEntry.stubs
  }
    
  func getSnapshot(for configuration: Covid19DynamicTypeIntent, in context: Context, completion: @escaping (CovidEntry) -> Void) {
    if context.isPreview {
      completion(.stubs)
    } else {
      self.callApiService(for: configuration.country?.identifier ?? "italy") { response in
        switch response {
        case .success(let entry):
          completion(entry)
        case .failure:
          completion(.stubs)
        }
      }
    }
  }
  
  func getTimeline(for configuration: Covid19DynamicTypeIntent, in context: Context, completion: @escaping (Timeline<CovidEntry>) -> Void) {
    self.callApiService(for: configuration.country?.identifier ?? "italy") { response in
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
