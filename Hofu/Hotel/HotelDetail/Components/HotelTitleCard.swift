//
//  Hotel.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelTitleCard: View {
    let name: String
    let location: (district: String, city: String)
    let rating: String
    let badges: [(HofuBadgeType, String, Image)]

    init(
        name: String,
        location: (district: String, city: String),
        rating: String,
        badges: [(HofuBadgeType, String, Image)] = [(.info, "Shop", Image("ic_shopping_bag")), (.warning, "Shop", Image("ic_shopping_bag"))]
    ) {
        self.name = name
        self.location = location
        self.rating = rating
        self.badges = badges
    }

    var body: some View {
        HofuCard {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(name)
                        .style(.displayXs(.semiBold))
                        .padding(.bottom, 4)

                    HStack(spacing: 0) {
                        Text("\(location.district), ")
                            .style(.textSm(.regular))
                            .foregroundStyle(.gray500)
                        Text(location.city)
                            .style(.textSm(.semiBold))
                            .foregroundStyle(.gray500)
                    }.padding(.bottom, 4)

                    HStack(spacing: 0) {
                        ForEach(0..<badges.count, id: \.self) { index in
                            let badge = badges[index]
                            HofuBadge(
                                type: badge.0,
                                title: badge.1,
                                leadingIcon: badge.2
                            )
                            .padding(.trailing, 4)
                        }

                        Spacer().frame(width: 4)
                        Image("ic_star")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.warning400)
                            .frame(width: 16, height: 16)
                        Text(rating)
                            .style(.textXss(.semiBold))
                    }
                }

                Spacer()
                HotelActionButtons()
            }
        }
    }
}

struct HotelActionButtons: View {
    var onMapPressed: () -> Void = { print("Map button tapped") }
    var onFavoritePressed: () -> Void = { print("Favorite button tapped") }
    var onSharePressed: () -> Void = { print("Share button tapped") }

    var body: some View {
        HStack {
            HofuCircleButton(
                icon: { Image("ic_map_pin_outline").resizable() },
                buttonSize: 32,
                iconPadding: 8,
                iconSize: 14,
                onPressed: onMapPressed
            )
            HofuCircleButton(
                icon: { Image("ic_heart_outline").resizable() },
                buttonSize: 32,
                iconPadding: 8,
                iconSize: 14,
                onPressed: onFavoritePressed
            )
            HofuCircleButton(
                icon: { Image("ic_share_2_outline").resizable() },
                buttonSize: 32,
                iconPadding: 8,
                iconSize: 14,
                onPressed: onSharePressed
            )
        }
    }
}


#Preview {
    HotelTitleCard(
        name: "Sakura Terrace",
        location: ("Setiabudi", "South Jakarta"),
        rating: "4.8/5"
    )
}
