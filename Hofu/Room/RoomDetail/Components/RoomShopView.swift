//
//  RoomShopView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomShopView: View {
    @State private var searchQuery = ""
    @State private var isSheetPresented = false
    @State private var isListView = false

    let products: [ProductItemInfo]

    init(
        products: [ProductItemInfo] = (0 ..< 6).map {
            ProductItemInfo(
                id: $0,
                title: "Product \($0 + 1)",
                price: "Rp\($0 * 100000)",
                description: "This is a detailed description of Product \($0 + 1).",
                rating: Double.random(in: 3.0 ... 5.0),
                imageName: "Sakura"
            )
        }
    ) {
        self.products = products
    }

    var body: some View {
        HofuCard {
            VStack(spacing: 16) {
                HStack {
                    Text("Hofu Shop Exclusive")
                        .style(.textSm(.semiBold))
                    Spacer()
                }

                LazyVGrid(
                    columns: isListView ? [GridItem(.flexible())] : [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 16
                ) {
                    ForEach(products) { product in
                        NavigationLink(
                            destination: RoomProductDetailView(product: product)
                        ) {
                            RoomProductItemView(info: product, isListView: isListView)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
                HofuOutlineButton(title: "See more products", onPressed: {})
            }
        }
    }
}

#Preview {
    RoomShopView(
    )
}
