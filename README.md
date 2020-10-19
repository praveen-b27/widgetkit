# Widgetkit
SwiftUI-WidgetKit 

The widget gives a quick action to information that’s important right now.
I have create a Widgets for COVID-19 Stats. 

![](Covid19Widgets.gif)

### Static Configuration:  ###

    StaticConfiguration(kind: kind, provider: GlobalStatsStaticProvider()) { entry in
      Covid19WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Covid Widget")
    .description("Show the latest details on the homescreen")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])

### Intent Configuration with Static Data: ###

    IntentConfiguration(kind: kind, intent: Covid19WidgetIntent.self, provider: GlobalStatsIntentProvider()) { entry in
      Covid19WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Covid Widget")
    .description("Show the latest details on the homescreen")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    
### Intent Configuration with Dynamic Data: ###

    IntentConfiguration(kind: kind, intent: Covid19DynamicTypeIntent.self, provider: GlobalStatsDynamicIntentProvider()) { entry in
      Covid19WidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Covid Widget")
    .description("Show the latest details on the homescreen")
    .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
