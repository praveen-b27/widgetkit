//
//  CovidModel.swift
//  Covid19
//
//  Created by pbhaskar on 20/08/20.
//

import Foundation

struct DailySummaryCaseStas: Decodable {
  let global: CaseStats
  let countries: [CaseStats]
  
  enum CodingKeys: String, CodingKey {
    case global = "Global"
    case countries = "Countries"
  }
}

struct CaseStats: Decodable {
  let id: String?
  let name: String?
  let iso: String?
  let newConfirmed: Int
  let totalConfirmed: Int
  let newDeaths: Int
  let totalDeaths: Int
  let newRecovered: Int
  let totalRecovered: Int
  let date: Date?
  
  var activeCases: Int {
    totalConfirmed - totalRecovered - totalDeaths
  }
  
  enum CodingKeys: String, CodingKey {
    case id = "Slug"
    case name = "Country"
    case iso = "CountryCode"
    case newConfirmed = "NewConfirmed"
    case totalConfirmed = "TotalConfirmed"
    case newDeaths = "NewDeaths"
    case totalDeaths = "TotalDeaths"
    case newRecovered = "NewRecovered"
    case totalRecovered = "TotalRecovered"
    case date = "Date"
  }
}

struct CountryTotalCase: Decodable {
  let country: String
  let confirmed: Int
  let deaths: Int
  let recovered: Int
  let active: Int
  let date: Date
  
  enum CodingKeys: String, CodingKey {
    case country = "Country"
    case confirmed = "Confirmed"
    case deaths = "Deaths"
    case recovered = "Recovered"
    case active = "Active"
    case date = "Date"
  }
}

struct Country1: Decodable {
  let id: String
  let name: String
  let iso: String
  
  enum CodingKeys: String, CodingKey {
    case id = "Slug"
    case name = "Country"
    case iso = "ISO2"
  }
}

struct DailyNewCases {
  var newCases: [Double] = []
  let maxValue = 15
  
  init(totalData: [CountryTotalCase]) {
    let data: [CountryTotalCase] = totalData.reversed()
    newCases = []
    for (index, eachData) in data.enumerated() {
      if index <= maxValue {
        let value = eachData.confirmed - data[index + 1].confirmed
        if value > 0 {
          newCases.append(Double(value))
        }
      } else {
        break
      }
    }
  }
}


struct TotalCaseCount {
  let title: String
  let confirmed: Int
  let death: Int
  let recovered: Int
  
  var sick: Int {
    confirmed - death - recovered
  }
  
  var recoveryRate: Double {
    (Double(recovered) / Double(confirmed))
  }
  
  var fatalityRate: Double {
    (Double(death) / Double(confirmed)) 
  }
}

