//
//  HotelAmenitiesCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

import SwiftUI

struct HotelAmenitiesCard: View {
    struct Amenity: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
    }

    let amenities: [Amenity]
    @State private var isShowMoreAmenities = false

    init(
        amenities: [Amenity] = [
            Amenity(icon: "ic_restaurant_menu", title: "Restaurant"),
            Amenity(icon: "ic_wifi_outline", title: "Free Wi-Fi"),
            Amenity(icon: "ic_sunrise_outline", title: "Free Breakfast"),
            Amenity(icon: "ic_restaurant_menu", title: "Swimming Pool"),
            Amenity(icon: "ic_restaurant_menu", title: "Spa Services"),
            Amenity(icon: "ic_restaurant_menu", title: "Fitness Center"),
            Amenity(icon: "ic_restaurant_menu", title: "Fitness Center"),
            Amenity(icon: "ic_restaurant_menu", title: "Fitness Center"),
            Amenity(icon: "ic_restaurant_menu", title: "Fitness Center")
        ]
    ) {
        self.amenities = amenities
    }

    var body: some View {
        HofuCard {
            VStack(alignment: .leading) {
                Text("Amenities")
                    .style(.textSm(.semiBold))
                    .padding(.bottom, 8)

                if !isShowMoreAmenities {
                    HStack(spacing: 16) {
                        ForEach(Array(amenities.prefix(3))) { amenity in
                            HStack {
                                Spacer()
                                VStack {
                                    Image(amenity.icon)
                                        .padding(.bottom, 2)
                                    Text(amenity.title)
                                        .style(.textXs(.regular))
                                        .foregroundStyle(.gray500)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                if isShowMoreAmenities {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: 3
                        ),
                        spacing: 8
                    ) {
                        ForEach(amenities) { amenity in
                            HStack {
                                Image(amenity.icon)
                                    .padding(.trailing, 4)
                                Text(amenity.title)
                                    .style(.textXs(.regular))
                                    .foregroundStyle(.gray)
                            }
                        }
                    }.padding(.bottom, 16)
                }

                Button(action: {
                    withAnimation {
                        isShowMoreAmenities.toggle()
                    }
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(isShowMoreAmenities ? "Show less" : "See more amenities")
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

#Preview {
    HotelAmenitiesCard()
}
