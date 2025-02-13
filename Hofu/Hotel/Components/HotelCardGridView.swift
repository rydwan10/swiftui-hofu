//
//  HotelCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/01/25.
//

import SwiftUI

struct HotelCardGrid: View {
    let image: String
    let title: String
    let city: String
    let country: String
    let isHaveShop: Bool
    let isHofuPartner: Bool
    let startingPrice: Double
    let rating: Double

    init(image: String, title: String, city: String, country: String, isHaveShop: Bool, isHofuPartner: Bool, startingPrice: Double, rating: Double) {
        self.image = image
        self.title = title
        self.city = city
        self.country = country
        self.isHaveShop = isHaveShop
        self.isHofuPartner = isHofuPartner
        self.startingPrice = startingPrice
        self.rating = rating
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 166)
                .clipped()
                .cornerRadius(28)
            VStack(alignment: .leading) {
                Text(title).style(.textSm(.semiBold))
                HStack(alignment: .center, spacing: 0) {
                    Text(city + ", ")
                        .style(.textXss(.regular))
                    Text(country)
                        .style(.textXss(.semiBold))
                }
                HStack(spacing: 2) {
                    if isHaveShop {
                        HofuBadge(type: .info, title: "Shop", leadingIcon: Image("ic_shopping_bag"))
                    }
                    if isHofuPartner {
                        HofuBadge(type: .warning, title: "Hofu Partner", leadingIcon: Image("ic_shopping_bag"))
                    }
                    
                }.frame(height: 16)
                
                HStack(spacing: 0) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Starts from").style(.tiny(.semiBold)).foregroundStyle(.gray600)
                            Text("Rp \(String(format: "%.2f", startingPrice))")
                                .style(.textXss(.semiBold))
                        }
                        Spacer()
                        Text("\(String(rating))/5").style(.tiny(.semiBold))
                    }
                }
            }
                .padding(.horizontal, 12)
                    .padding(.top, 6)
                    .padding(.bottom, 14)
        }
//        .frame(width: .infinity)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(
                color: Color(.Gray600, opacity: 0.1),
                radius: 8,
                x: 0,
                y: 4
            ).padding(.bottom, 16)
    }
}

#Preview {
    VStack(spacing: 24) {
        HStack(spacing: 16) {
            HotelCardGrid(
                image: "Sakura",
                title: "Sakura Terrace",
                city: "South Jakarta",
                country: "Indonesia",
                isHaveShop: false,
                isHofuPartner: false,
                startingPrice: 400_000,
                rating: 4.3
            )

            HotelCardGrid(
                image: "Sakura",
                title: "Sakura Terrace",
                city: "South Jakarta",
                country: "Indonesia",
                isHaveShop: true,
                isHofuPartner: true,
                startingPrice: 400_000,
                rating: 4.3
            )
        }
        HStack(spacing: 16) {
            HotelCardGrid(
                image: "Sakura",
                title: "Sakura Terrace",
                city: "South Jakarta",
                country: "Indonesia",
                isHaveShop: true,
                isHofuPartner: true,
                startingPrice: 400_000,
                rating: 4.3
            )

            HotelCardGrid(
                image: "Sakura",
                title: "Sakura Terrace",
                city: "South Jakarta",
                country: "Indonesia",
                isHaveShop: true,
                isHofuPartner: true,
                startingPrice: 400_000,
                rating: 4.3
            )
        }
    }.padding().frame(maxWidth: .infinity).background(Color.gray.opacity(0.1))
}
