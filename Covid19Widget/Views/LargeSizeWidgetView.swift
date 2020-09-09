//
//  LargeSizeWidgetView.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 20/08/20.
//

import SwiftUI
import WidgetKit

struct LargeSizeWidgetView: View {
  var entry: CovidEntry
  
  var body: some View {
    VStack {
      MediumSizeWidgetView(entry: entry)
      let totalCase = TotalCaseCount(title: "", confirmed: entry.countryTotalCase.confirmed, death: entry.countryTotalCase.deaths, recovered: entry.countryTotalCase.recovered)
      
      HStack() {
        VStack {
          ProgressBar(progress: totalCase.recoveryRate)
            .frame(width: 70.0, height: 70.0)
            .padding(10.0)
          
          Text("Recovery Rate")
            .padding(.bottom)
            .font(.caption)
        }
        .padding(.leading, 35.0)
        Spacer()
        VStack {
          ProgressBar(progress: totalCase.fatalityRate)
            .frame(width: 70.0, height: 70.0)
            .padding(10.0)
          
          Text("Fatality Rate")
            .padding(.bottom)
            .font(.caption)
        }
        .padding(.trailing, 35.0)
      }
      .padding(.horizontal)

      HStack(alignment: .center, spacing: 5) {

        ForEach(entry.dailyNewCases.reversed(), id: \.self){
          data in
          BarView(value: data, cornerRadius: 3, maxValue: entry.dailyNewCases.max() ?? 0.0)
        }
      }
      .padding([.top, .leading, .trailing], 5).animation(.default)
      Text(entry.country)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .bold()
        .padding(.bottom, 5.0)
    }
  }
}

struct ProgressBar: View {
  var progress: Double
  
  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 10.0)
        .opacity(0.3)
        .foregroundColor(Color.red)
      
      Circle()
        .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color.red)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear)
      
      Text(String(format: "%.0f %%", min(progress, 1.0)*100.0))
        .font(.subheadline)
        .bold()
    }
  }
}

struct LargeSizeWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    LargeSizeWidgetView(entry: CovidEntry.stubs)
      .previewContext(WidgetPreviewContext(family: .systemLarge))
  }
}
