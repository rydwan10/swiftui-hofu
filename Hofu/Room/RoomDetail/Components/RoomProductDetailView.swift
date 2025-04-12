//
//  RoomProductDetailView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomProductDetailView: View {
    var product: ProductItemInfo
    @Environment(\.presentationMode) var presentationMode

    init(product: ProductItemInfo) {
        self.product = product
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Product Image
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(28)

                // Product Title and Rating
                HofuCard {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(product.price)
                                .style(.displayXs(.semiBold))
                                .padding(.bottom, 8)
                            Text(product.title)
                                .style(.textMd(.regular))
                                .foregroundStyle(.gray600)
                                .padding(.bottom, 4)
                            HStack {
                                ForEach(0 ..< 5) { index in
                                    Image(systemName: index < Int(product.rating) ? "star.fill" : "star")
                                        .foregroundColor(.warning400)
                                }
                                Text(String(format: "%.1f", product.rating))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                }

                HofuCard {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Description")
                                .style(.textSm(.semiBold))
                                .padding(.bottom, 8)

                            Text(product.description)
                                .style(.textXs())
                                .foregroundColor(.gray500)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                }

                HofuCard {
                    HStack {
                        Spacer()
                        Text("Can only be purchased after booking")
                            .style(.textSm(.semiBold))
                            .foregroundStyle(.gray600)
                        Spacer()
                    }
                }
                Spacer()
            }

            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "chevron.left")
//                Text("Back")
//            }
//        })
    }
}

#Preview {
    RoomProductDetailView(product:
        ProductItemInfo(
            id: 1,
            title: "Night Lamp",
            price: "100.000",
            description: "lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem!",
            rating: 5,
            imageName: "Sakura"
        )
    )
}
