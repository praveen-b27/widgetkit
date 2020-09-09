//
//  StatsViewModel.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 20/08/20.
//

import Foundation
import SwiftUI

class StatsViewModel: ObservableObject {
  let service = Covid19APIService.shared
  @Published var globalStats: CaseStats?

  init() {
    self.fetchGlobalStats()
  }
  
  func fetchGlobalStats() {
    self.service.getGlobalTotalCount { (result) in
      switch result {
      case .success(let stats):
        DispatchQueue.main.async {
          self.globalStats = stats.global
        }
      case .failure(let error):
        print("error :: \(error)")
      }
    }
  }
  
  func fetchTotalStats() {
    self.service.getCountryTotalCount(countryId: "india") { (result) in
      switch result {
      case .success(let stats):
        print("sd")
      case .failure(let error):
        print("error :: \(error)")
      }
    }
  }
  
  func fetchCountries() {
    self.service.getCountries { (result) in
      switch result {
      case .success(let stats):
        print(stats)
      case .failure(let error):
        print("error :: \(error)")
      }
    }
  }
}

enum GlobalStatsViewData {
  case active
  case confirmed
  case recovered
  case deceased
  
  func getThemeTitle() -> String {
    switch self {
    case .active:
      return "Active"
    case .confirmed:
      return "Confirmed"
    case .recovered:
      return "Recovered"
    case .deceased:
      return "Deceased"
    }
  }
  
  func getThemeColor() -> Color {
    switch self {
    case .active:
      return .accentColor
    case .confirmed:
      return .red
    case .recovered:
      return .green
    case .deceased:
      return .gray
    }
  }
  
  func getNewCount(_ stats: CaseStats) -> Int {
    switch self {
    case .active:
      return stats.activeCases
    case .confirmed:
      return stats.newConfirmed
    case .recovered:
      return stats.newRecovered
    case .deceased:
      return stats.newDeaths
    }
  }
  
  func getTotalCount(_ stats: CaseStats) -> Int {
    switch self {
    case .active:
      return stats.activeCases
    case .confirmed:
      return stats.totalConfirmed
    case .recovered:
      return stats.totalRecovered
    case .deceased:
      return stats.totalDeaths
    }
  }
  
  func getCountryTotalCount(_ stats: CountryTotalCase) -> Int {
    switch self {
    case .active:
      return stats.active
    case .confirmed:
      return stats.confirmed
    case .recovered:
      return stats.recovered
    case .deceased:
      return stats.deaths
    }
  }
  
  func getGradientColor() -> Gradient {
    switch self {
    case .active:
      return Gradient(colors: [Color(red: 177/255, green: 177/255, blue: 255/255), Color(red: 216/255, green: 216/255, blue: 255/255)])
    case .confirmed:
      return Gradient(colors: [Color(red: 255/255, green: 157/255, blue: 157/255), Color(red: 255/255, green: 196/255, blue: 196/255)])
    case .recovered:
      return Gradient(colors: [Color(red: 157/255, green: 255/255, blue: 157/255), Color(red: 196/255, green: 255/255, blue: 196/255)])
    case .deceased:
      return Gradient(colors: [Color(red: 206/255, green: 206/255, blue: 206/255), Color(red: 266/255, green: 266/255, blue: 266/255)])
    }
  }
}
