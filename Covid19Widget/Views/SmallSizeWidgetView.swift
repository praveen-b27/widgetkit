//
//  SmallSizeWidgetView.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 20/08/20.
//

import WidgetKit
import SwiftUI

struct SmallSizeWidgetView: View {
  var entry: CovidEntry

  let gradient = Gradient(colors: [Color(red: 255/255, green: 157/255, blue: 157/255), Color(red: 255/255, green: 196/255, blue: 196/255)])
  
  var body: some View {
    ZStack {
      Rectangle()
        .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .topTrailing))

      VStack(alignment: .leading, spacing: 6) {
        HStack {
          Image("Corona")
            .resizable()
            .frame(width: 35.0, height: 35.0)
          Text(entry.country.uppercased())
            .font(.title2)
          Spacer()
        }
        Text("\u{2191} \(entry.countryTotalCase.confirmed)")
          .bold()
          .foregroundColor(.red)
        Text("\u{2191} \(entry.countryTotalCase.recovered)")
          .bold()
          .foregroundColor(.green)
        Text("\u{2191} \(entry.countryTotalCase.deaths)")
          .bold()
          .foregroundColor(.gray)
      }
      .padding()
      
    }
  }
}

struct SmallSizeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
      SmallSizeWidgetView(entry: CovidEntry.stubs)
          .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
