//
//  ContentView.swift
//  Shared
//
//  Created by pbhaskar on 20/08/20.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel: StatsViewModel = StatsViewModel()
  
  var body: some View {
    VStack {
      HStack {
        Text("COVID 19 Stats")
          .foregroundColor(.black)
          .font(.largeTitle)
          .padding(.leading)
        Spacer()
      }
      GlobalStatsView(globalData: self.$viewModel.globalStats)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct GlobalStatsView: View {
  //  let totalStatus: GlobalStatsViewData
  @Binding var globalData: CaseStats?
  let glabalStats: [GlobalStatsViewData] = [.confirmed, .recovered , .deceased]
  
  var body: some View {
    
    VStack {
      if let data = globalData {
        Text("Active \(data.activeCases)")
          .foregroundColor(.accentColor)
          .font(.largeTitle)
          .bold()
          .padding(.top, 20.0)
      } else {
        Text("Active 434345443")
          .foregroundColor(.accentColor)
          .font(.largeTitle)
          .bold()
          .redacted(reason: .placeholder)
          .padding(.top, 20.0)
      }
      ForEach(glabalStats, id: \.self) { eachStatus in
        let themeColor = eachStatus.getThemeColor()
        ZStack {
          Rectangle()
            .fill(LinearGradient(gradient: eachStatus.getGradientColor(), startPoint: .leading, endPoint: .topTrailing))
            .frame(height: 150.0)
            .cornerRadius(10.0)
            .padding([.leading, .bottom, .trailing], 30.0)
          
          VStack {
            Text(eachStatus.getThemeTitle())
              .foregroundColor(themeColor)
              .bold()
              .padding()
            
            if let data = globalData {
              Text("+\(eachStatus.getNewCount(data))")
                .foregroundColor(themeColor)
              Text("\(eachStatus.getTotalCount(data))")
                .foregroundColor(themeColor)
                .font(.largeTitle)
                .bold()
            } else {
              Text("+23232")
                .foregroundColor(themeColor)
                .redacted(reason: .placeholder)
              Text("+44343423")
                .foregroundColor(themeColor)
                .font(.largeTitle)
                .bold()
                .redacted(reason: .placeholder)
            }
          }
          .padding(.bottom, 25.0)
        }
      }
      Spacer()
      Button(action: {
        
      }) {
        Text("Show details")
          .font(.title2)
          .foregroundColor(.white)
          .padding()
      }
      .background(Color.blue)
      .cornerRadius(5.0)
    }
  }
}
