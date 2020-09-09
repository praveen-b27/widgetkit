//
//  SecondaryWidget.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 23/08/20.
//
import WidgetKit
import SwiftUI

struct SecondaryWidget: Widget {
  private let kind: String = "SecondaryWidget"
  
  public var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: GlobalStatsStaticProvider()) { entry in
      SecondaryWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Secondary Widget")
    .description("Show the latest details on the homescreen")
    .supportedFamilies([.systemSmall])
  }
}

struct SecondaryWidgetEntryView : View {
  var entry: CovidEntry
  
  var body: some View {
    Text("Hello World")
  }
}

struct SecondaryWidget_Previews: PreviewProvider {
    static var previews: some View {
      SecondaryWidgetEntryView(entry: CovidEntry.stubs)
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
