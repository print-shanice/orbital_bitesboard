//
//  BitesBoardWidgetBundle.swift
//  BitesBoardWidget
//
//  Created by lai shanice on 16/7/25.
//

import WidgetKit
import SwiftUI

struct LastReviewEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct LastReviewProvider: TimelineProvider {
    func placeholder(in context: Context) -> LastReviewEntry {
        LastReviewEntry(
            date: Date(),
            image: UIImage(named: "placeholder")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (LastReviewEntry) -> Void) {
        completion(loadLastReviewEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<LastReviewEntry>) -> Void) {
        let entry = loadLastReviewEntry()
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func loadLastReviewEntry() -> LastReviewEntry {
        let defaults = UserDefaults(suiteName: "group.com.orbital.bitesboard")
        
        let imageData = defaults?.data(forKey: "lastReviewImage")
        let image = imageData.flatMap { UIImage(data: $0) } ?? UIImage(named: "placeholder")!
        
        
        return LastReviewEntry(
            date: Date(),
            image: image
        )
    }
}

struct LastReviewWidgetView: View {
    let entry: LastReviewEntry
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            switch family {
                case .systemSmall:
                    Image(uiImage: entry.image)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 169, height: 169)
                               .cornerRadius(15)
                               .clipped()
                default:
                    Image(uiImage: entry.image)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 360, height: 169)
                               .cornerRadius(15)
                               .clipped()
            }
        }
        .widgetURL(URL(string: "bitesboard://lastReview"))
    }
}

struct LastReviewWidget: Widget {
    let kind: String = "BitesBoardWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LastReviewProvider()) { entry in
            LastReviewWidgetView(entry: entry)
        }
        .configurationDisplayName("Last Meal Review")
        .description("Shows the photo of your most recent meal review.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
