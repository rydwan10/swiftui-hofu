//
//  RoomProductItemView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct ProductItemInfo: Identifiable {
    let id: Int
    let title: String
    let price: String
    let description: String
    let rating: Double
    let imageName: String
}

struct RoomProductItemView: View {
    let info: ProductItemInfo
    let isListView: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image(info.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(28)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: isListView ? 400 : 200
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(info.title)
                    .style(.textMd(.semiBold))
                    .lineLimit(1)

                Text(info.price)
                    .style(.textSm(.semiBold))
                    .foregroundStyle(.gray500)

                Text(info.description)
                    .style(.textXs())
                    .foregroundStyle(.gray400)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image("ic_star")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.warning400)
                        .frame(width: 16, height: 16)

                    Text(String(format: "%.1f", info.rating))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.padding(12)
                .frame(maxWidth: .infinity, alignment: isListView ? .leading : .center)
        }

        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(.gray200, lineWidth: 1)
        )
//        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    RoomProductItemView(
        info: .init(
            id: 1, 
            title: "Test",
            price: "10000",
            description: "test",
            rating: 5,
            imageName: "Sakura"
        ),
        isListView: false
    )
}
