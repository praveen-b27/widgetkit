//
//  BarChartView.swift
//  Covid19WidgetExtension
//
//  Created by pbhaskar on 21/08/20.
//

import SwiftUI

struct BarView: View{
  
  var value: Double
  var cornerRadius: CGFloat
  var maxValue: Double

  var body: some View {
    VStack {
      ZStack (alignment: .bottom) {
        RoundedRectangle(cornerRadius: cornerRadius)
          .frame(width: 15, height: 50).foregroundColor(.black)
        let data = CGFloat(((value/maxValue) * 100) / 2)
        RoundedRectangle(cornerRadius: cornerRadius)
          .frame(width: 15, height: data).foregroundColor(.green)
        
      }.padding(.bottom, 8)
    }
    
  }
}
