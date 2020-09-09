//
//  MediumSizeWidgetView.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 20/08/20.
//

import WidgetKit
import SwiftUI

struct MediumSizeWidgetView: View {
  var entry: CovidEntry
  let gradient = Gradient(colors: [Color(red: 255/255, green: 157/255, blue: 157/255), Color(red: 255/255, green: 196/255, blue: 196/255)])
  
  var body: some View {
    VStack {
      HStack {
        MediumSizeContentView(enumStatus: .active, globalStats: entry.countryTotalCase)
        MediumSizeContentView(enumStatus: .confirmed, globalStats: entry.countryTotalCase)
      }
      HStack {
        MediumSizeContentView(enumStatus: .recovered, globalStats: entry.countryTotalCase)
        MediumSizeContentView(enumStatus: .deceased, globalStats: entry.countryTotalCase)
      }
    }
    .padding(.all)
  }
}

struct MediumSizeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
      MediumSizeWidgetView(entry: CovidEntry.stubs)
          .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct MediumSizeContentView: View {
  let enumStatus: GlobalStatsViewData
  let globalStats: CountryTotalCase
  
  var body: some View {
    ZStack {
      ContainerRelativeShape()
        .fill(LinearGradient(gradient: enumStatus.getGradientColor(), startPoint: .leading, endPoint: .topTrailing))
      VStack {
        Text(enumStatus.getThemeTitle())
          .foregroundColor(.black)
          .bold()
        
        Text("\(enumStatus.getCountryTotalCount(globalStats))")
          .foregroundColor(.black)
          .bold()
      }
    }
  }
}
