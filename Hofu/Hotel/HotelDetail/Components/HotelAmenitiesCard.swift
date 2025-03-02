//
//  HotelAmenitiesCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelAmenitiesCard: View {
    struct Amenity: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
    }

    let amenities: [Amenity]
    var onSeeMorePressed: () -> Void

    init(
        amenities: [Amenity] = [
            Amenity(icon: "ic_restaurant_menu", title: "Restaurant"),
            Amenity(icon: "ic_wifi_outline", title: "Free Wi-Fi"),
            Amenity(icon: "ic_sunrise_outline", title: "Free Breakfast")
        ],
        onSeeMorePressed: @escaping () -> Void = { print("See more amenities pressed") }
    ) {
        self.amenities = amenities
        self.onSeeMorePressed = onSeeMorePressed
    }

    var body: some View {
        HofuCard {
            VStack(alignment: .leading) {
                Text("Amenities")
                    .style(.textSm(.semiBold))
                    .padding(.bottom, 8)

                HStack {
                    ForEach(amenities) { amenity in
                        Spacer()
                        VStack {
                            Image(amenity.icon)
                                .padding(.bottom, 2)
                            Text(amenity.title)
                                .style(.textXs(.regular))
                                .foregroundStyle(.gray500)
                        }
                    }
                    Spacer()
                }.padding(.bottom, 16)

                Button(action: onSeeMorePressed) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("See more amenities")
                            .style(.textXs(.semiBold))
                            .foregroundStyle(.brand600)
                        Spacer()
                    }
                }
            }
        }
    }
}
#Preview {
    HotelAmenitiesCard()
}
