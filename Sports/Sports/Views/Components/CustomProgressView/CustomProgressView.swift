//
//  CustomProgressView.swift
//  Sports
//
//  Created by Mohammed Skaik on 06/10/2024.
//

import SwiftUI

struct CustomProgressView: View {
    @Environment(\.progressKey) var progress
    @State private var degree: Int = 270
    @State private var spinnerLength = 0.6

    var body: some View {
        ZStack {
            Color.gray.opacity(0.4).ignoresSafeArea()
            if let value = progress.value {
                ProgressView(value: value, total: 1.0)
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(width: 70, height: 70)
                    .padding()
            } else {
                ProgressView()
                    .progressViewStyle(CircularLoderViewStyle())
                    .frame(width: 70, height: 70)
                    .padding()
            }
        }
    }
}

#Preview {
    CustomProgressView()
}
