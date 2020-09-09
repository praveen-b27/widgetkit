//
//  CovidApi.swift
//  Covid19
//
//  Created by pbhaskar on 20/08/20.
//

import Foundation

enum Covid19APIError: Error {
  case invalidURL
  case invalidSerialization
  case badHTTPResponse
  case error(NSError)
  case noData
}

protocol Covid19Services {
  func getGlobalTotalCount(completion: @escaping (Result<DailySummaryCaseStas, Covid19APIError>) -> ())
  func getCountryTotalCount(countryId: String, completion: @escaping (Result<[CountryTotalCase], Covid19APIError>) -> ())
  func getCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ())
}

class Covid19APIService: Covid19Services {
  
  static let shared = Covid19APIService()
  private let baseAPIURL = "https://api.covid19api.com"
  private let urlSession = URLSession.shared
  private let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()
  
  private init() {}
  
  func getGlobalTotalCount(completion: @escaping (Result<DailySummaryCaseStas, Covid19APIError>) -> ()) {
    guard let url = URL(string: "\(baseAPIURL)/summary") else {
      completion(.failure(.invalidURL))
      return
    }
    
    if let path = Bundle.main.path(forResource: "globalData", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let model = try jsonDecoder.decode(DailySummaryCaseStas.self, from: data)
        completion(.success(model))
      } catch {
        completion(.failure(Covid19APIError.noData))
      }
    }
    
//    executeDataTaskAndDecode(with: url) { (result: Result<DailySummaryCaseStas, Covid19APIError>) in
//      switch result {
//      case .success(let response):
//        completion(.success(response))
//      case .failure(let error):
//        completion(.failure(error))
//      }
//    }
  }
  
  func getCountryTotalCount(countryId: String, completion: @escaping (Result<[CountryTotalCase], Covid19APIError>) -> ()) {
    guard let url = URL(string: "\(baseAPIURL)/total/country/\(countryId)") else {
      completion(.failure(.invalidURL))
      return
    }
    
    if let path = Bundle.main.path(forResource: countryId, ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        let model = try jsonDecoder.decode([CountryTotalCase].self, from: data)
        completion(.success(model))
      } catch {
        completion(.failure(Covid19APIError.noData))
      }
    }
    
//    executeDataTaskAndDecode(with: url) { (result: Result<[CountryTotalCase], Covid19APIError>) in
//      switch result {
//      case .success(let response):
//        let dailyData = DailyNewCases(totalData: response)
//        completion(.success(dailyData))
//      case .failure(let error):
//        completion(.failure(error))
//      }
//    }
  }
  
  func getCountries(completion: @escaping (Result<[Country], Covid19APIError>) -> ()) {
    guard let url = URL(string: "\(baseAPIURL)/countries") else {
      completion(.failure(.invalidURL))
      return
    }
    
    if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        let model = try jsonDecoder.decode([Country1].self, from: data)
        let countryModel = model.map { eachCountry in
          Country(identifier: eachCountry.id, display: eachCountry.name)
        }
        completion(.success(countryModel))
      } catch {
        completion(.failure(Covid19APIError.noData))
      }
    }
  }
  
  private func executeDataTaskAndDecode<D: Decodable>(with url: URL, completion: @escaping (Result<D, Covid19APIError>) -> ()) {
    urlSession.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(.error(error as NSError)))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
        completion(.failure(.badHTTPResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.noData))
        return
      }
      
      do {
        let model = try self.jsonDecoder.decode(D.self, from: data)
        completion(.success(model))
      } catch let error as NSError{
        print(error.localizedDescription)
        completion(.failure(.invalidSerialization))
      }
    }.resume()
  }
}
