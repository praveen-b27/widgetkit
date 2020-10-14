//
//  Covid19Widget.swift
//  Covid19Widget
//
//  Created by pbhaskar on 20/08/20.
//

import WidgetKit
import SwiftUI
import Intents

struct CovidEntry: TimelineEntry {
  public let date: Date
  public let dailyNewCases: [Double]
  public let country: String
  public let countryTotalCase: CountryTotalCase
  
  static var stubs: CovidEntry {
    CovidEntry(date: Date(), dailyNewCases: [4443,52234,6232,6833,6834,7322,7233,8222,8222,9333,9822,9723,10330,11339], country: "India", countryTotalCase: CountryTotalCase(country: "", confirmed: 2905825, deaths: 54849, recovered: 2158946, active: 692030, date: Date()))
  }
}

struct PlaceholderView : View {
  var entry: CovidEntry
  
  var body: some View {
    Covid19WidgetEntryView(entry: entry).redacted(reason: .placeholder)
  }
}

struct Covid19WidgetEntryView : View {
  var entry: CovidEntry
  @Environment(\.widgetFamily) var family: WidgetFamily
  
  @ViewBuilder
  var body: some View {
    switch family {
    case .systemSmall:
      SmallSizeWidgetView(entry: entry)
    case .systemMedium:
      MediumSizeWidgetView(entry: entry)
    default:
      LargeSizeWidgetView(entry: entry)
    }
  }
}

@main
struct Covid19Widget: Widget {
  private let kind: String = "Covid19Widget"
  
  public var body: some WidgetConfiguration {
    
    StaticConfiguration(kind: kind, provider: GlobalStatsStaticProvider()) { entry in
      Covid19WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Covid Widget")
    .description("Show the latest details on the homescreen")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    
//    IntentConfiguration(kind: kind, intent: Covid19WidgetIntent.self, provider: GlobalStatsIntentProvider()) { entry in
//      Covid19WidgetEntryView(entry: entry)
//    }
//    .configurationDisplayName("Covid Widget")
//    .description("Show the latest details on the homescreen")
//    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
//
//    IntentConfiguration(kind: kind, intent: Covid19DynamicTypeIntent.self, provider: GlobalStatsDynamicIntentProvider()) { entry in
//      Covid19WidgetEntryView(entry: entry)
//    }
//    .configurationDisplayName("Covid Widget")
//    .description("Show the latest details on the homescreen")
//    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
  }
}

struct Covid19Widget_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Covid19WidgetEntryView(entry: CovidEntry.stubs)
        .previewContext(WidgetPreviewContext(family: .systemMedium))
      PlaceholderView(entry: CovidEntry.stubs)
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
  }
}

struct EmojiBundle: WidgetBundle {
  @WidgetBundleBuilder
  var body: some Widget {
    Covid19Widget()
    SecondaryWidget()
  }
}
