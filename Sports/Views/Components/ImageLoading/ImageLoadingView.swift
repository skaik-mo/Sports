//
//  ImageLoadingView.swift
//  Sports
//
//  Created by Mohammed Skaik on 07/10/2024.
//


import SwiftUI

struct ImageLoadingView: View {
    @State var imageLoader: ImageLoader

    init(url: String?) {
        self._imageLoader = State(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.logoOlympic)
                    .resizable()
                    .scaledToFit()
            }
        }
            .roundedCornerWithBorder(lineWidth: 1, borderColor: .main, radius: 20, corners: .allCorners)
            .onAppear {
            imageLoader.fetch()
        }
    }

}