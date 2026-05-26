//
//  HeaderCell.swift
//  Sports
//
//  Created by Mohammed Skaik on 08/10/2024.
//


import SwiftUI

struct HeaderCell: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.custom("Poppins-Bold", size: 24))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 15)
            .foregroundStyle(Color.foreground)
    }
}

#Preview {
    HeaderCell(title: "Title")
}
