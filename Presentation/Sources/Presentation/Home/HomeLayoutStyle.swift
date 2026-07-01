//
//  HomeLayoutStyle.swift
//  Presentation
//
//  Created by Mohammed Skaik on 01/07/2026.
//

import DesignSystem
import SwiftUI

enum HomeLayoutStyle: SegmentedLayoutOption {
    case waterfall
    case list

    var columns: [GridItem] {
        switch self {
        case .waterfall:
            return [
                GridItem(.flexible(), spacing: AppSpacing.lg, alignment: .top),
                GridItem(.flexible(), spacing: AppSpacing.lg, alignment: .top)
            ]
        case .list:
            return [GridItem(.flexible())]
        }
    }

    var heightImage: CGFloat? {
        switch self {
        case .waterfall: return nil
        case .list: return 150
        }
    }

    var font: Font {
        return switch self {
        case .waterfall:  AppFonts.medium20
        case .list:  AppFonts.medium26
        }
    }

    var systemImage: String {
        switch self {
        case .waterfall: return AppIcons.grid2x2
        case .list: return AppIcons.list1x2
        }
    }

}
