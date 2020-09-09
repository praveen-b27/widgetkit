//
//  CovidWidgetTimelineProvider.swift
//  Covid19 (iOS)
//
//  Created by pbhaskar on 20/08/20.
//

import WidgetKit
import UIKit

struct GlobalStatsStaticProvider: TimelineProvider {
  typealias Entry = CovidEntry

  func placeholder(with: Context) -> CovidEntry {
    CovidEntry.stubs
  }

  func snapshot(with context: Context, completion: @escaping (CovidEntry) -> ()) {
    let entry = CovidEntry.stubs
    completion(entry)
  }

  func timeline(with context: Context, completion: @escaping (Timeline<CovidEntry>) -> ()) {
    let entry = CovidEntry.stubs

    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
