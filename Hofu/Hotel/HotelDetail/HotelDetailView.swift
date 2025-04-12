//
//  HotelDetail.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 13/02/25.
//
import SwiftUI

struct HotelDetailView: View {
    @EnvironmentObject var routeManager: RouteManager

    let id: Int
    let name: String
    let image: String
    let price: String
    let location: (district: String, city: String)
    let description: String
    let rating: String

    init(
        id: Int,
        name: String,
        image: String = "Sakura",
        price: String = "Rp120.000",
        location: (district: String, city: String) = ("Setiabudi", "South Jakarta"),
        description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip.",
        rating: String = "4/5"
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.location = location
        self.description = description
        self.rating = rating
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                // Header Image
                HotelHeaderImage(imageName: image)

                VStack {
                    // Title Card
                    HotelTitleCard(
                        name: name,
                        location: location,
                        rating: rating
                    ).padding(.bottom, 8)

                    // Description Card
                    HotelDescriptionCard(description: description)
                        .padding(.bottom, 8)

                    // Amenities Card
                    HotelAmenitiesCard()
                        .padding(.bottom, 8)

                    // Room Cards
                    HotelRoomsCard()
                        .padding(.bottom, 24)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline) // Menentukan tampilan title secara inline
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(.gray50)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                HotelPriceFooter(
                    price: price,
                    onCheckoutPressed: {
                        routeManager.navigate(to: .checkoutRoom)
                    }
                )
            }
        }
        .toolbarBackground(.white, for: .bottomBar)
        .toolbarBackgroundVisibility(.visible, for: .bottomBar)
    }
}

#Preview("HotelDetailView Preview") {
    HotelDetailView(
        id: 1,
        name: "Sakura Terrace",
        image: "Sakura",
        price: "Rp120.000",
        description: "Experience luxury in the heart of Jakarta. Our hotel offers premium amenities and exceptional service."
    ).environmentObject(RouteManager())
}

#Preview("HotelTitleCard Preview") {
    HotelTitleCard(
        name: "Sakura Terrace",
        location: ("Setiabudi", "South Jakarta"),
        rating: "4.8/5"
    )
    .padding()
}

#Preview("HotelAmenitiesCard Preview") {
    HotelAmenitiesCard()
        .padding()
}

#Preview("RoomCard Preview") {
    RoomCard(info: RoomInfo(
        id: 1,
        title: "Deluxe Suite",
        price: "Rp250.000",
        amenities: ["ic_tv_outline", "ic_double_bed_outline", "ic_refrigerator_outline", "ic_wifi_outline", "ic_sunrise_outline"]
    ))
    .padding()
}

#Preview("RoomDetailView Preview") {
    @Previewable @State var isShowingSheetDetailRoom = false
    return RoomDetailView(roomInfo: RoomInfo(
        id: 2,
        title: "Executive Suite",
        price: "Rp350.000"
    ), isShowingSheetDetailRoom: $isShowingSheetDetailRoom)
}

#Preview("RoomShopView Preview") {
    RoomShopView()
}
