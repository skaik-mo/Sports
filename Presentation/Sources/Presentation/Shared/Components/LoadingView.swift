//
//  LoadingView.swift
//  Presentation
//
//  Created by Mohammed Skaik on 08/07/2026.
//

import SwiftUI
import DesignSystem

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background)
    }
}


#Preview {
    LoadingView()
}
