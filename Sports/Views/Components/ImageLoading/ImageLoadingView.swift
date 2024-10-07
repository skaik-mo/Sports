//
//  ImageLoadingView.swift
//  Sports
//
//  Created by Mohammed Skaik on 07/10/2024.
//


import SwiftUI

struct ImageLoadingView: View {
    @State var imageLoader: ImageLoader
    var width: CGFloat
    var height: CGFloat

    init(url: String?, width: CGFloat, height: CGFloat) {
        self._imageLoader = State(wrappedValue: ImageLoader(url: url))
        self.width = width
        self.height = height
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
            .frame(width: width, height: height)
            .roundedCornerWithBorder(lineWidth: 1, borderColor: .main, radius: 20, corners: .allCorners)
            .onAppear {
            imageLoader.fetch()
        }
    }

}