//
//  RemoteImage.swift
//  DesignSystem
//
//  Created by Mohammed Skaik on 07/07/2026.
//

import SwiftUI
import Kingfisher

public struct RemoteImage<PlaceholderView: View, FailureView: View>: View {
    private let url: URL?
    private let placeholderView: PlaceholderView
    private let failureView: FailureView

    public init(
        url: URL?,
        @ViewBuilder placeholderView: () -> PlaceholderView,
        @ViewBuilder failureView: () -> FailureView,
    ) {
        self.url = url
        self.placeholderView = placeholderView()
        self.failureView = failureView()
    }

    public var body: some View {
        KFImage.url(url)
            .resizable()
            .cancelOnDisappear(true)
            .onFailureView { placeholderView }
            .placeholder { failureView }
    }
}
