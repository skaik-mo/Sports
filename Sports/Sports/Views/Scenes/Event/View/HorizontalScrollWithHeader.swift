//
//  HorizontalScrollWithHeader.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//


import SwiftUI

struct HorizontalScrollWithHeader<T: Identifiable, Content: View>: View {
    @ViewBuilder private let content: (_ event: T) -> Content
    let title: String
    let padding: CGFloat = 15
    let events: [T]

    init(title: String, events: [T], content: @escaping (_ event: T) -> Content) {
        self.title = title
        self.events = events
        self.content = content
    }

    var body: some View {
        if events.isEmpty { EmptyView() }
        else {
            LazyVStack(spacing: 5) {
                HeaderCell(title: title)
                ScrollView(.horizontal) {
                    LazyHStack(spacing: padding) {
                        ForEach(events) { event in
                            content(event)
                        }
                    }
                        .padding(padding)
                        .scrollTargetLayout()
                }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    HorizontalScrollWithHeader(title: "Welcome", events: [Event(sport: .football, dictionary: ["w": "w"])!, Event(sport: .football, dictionary: ["w": "w"])!, Event(sport: .football, dictionary: ["w": "w"])!]) { item in
        Rectangle()
            .foregroundStyle(.yellow)
            .frame(width: UIScreen.screenWidth - 30, height: 100)
    }
}
