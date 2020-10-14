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

  func getSnapshot(in context: Context, completion: @escaping (CovidEntry) -> Void) {
    let entry = CovidEntry.stubs
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<CovidEntry>) -> Void) {
    let entry = CovidEntry.stubs

    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
  
  func placeholder(in with: Context) -> CovidEntry {
    CovidEntry.stubs
  }
}

