//
//  RoomBookNowFooterView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomBookNowFooterView: View {
    let price: String
    var onBookNow: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text(price)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("/per night")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            HofuButton(
                title: "Book Now",
                onPressed: {
                    onBookNow()
                },
                isFullWidth: true
            )
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .border(width: 2, edges: [.top], color: .gray100)
        .background(.gray25)
    }
}

#Preview {
    RoomBookNowFooterView(
        price: "$120",
        onBookNow: {}
    )
}
