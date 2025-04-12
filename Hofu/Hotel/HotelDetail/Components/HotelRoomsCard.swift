//
//  HotelRoomsCard.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 01/03/25.
//

import SwiftUI

struct HotelRoomsCard: View {
    let rooms: [RoomInfo]

    init(rooms: [RoomInfo] = [
        RoomInfo(id: 1, title: "Suite Room", price: "Rp120.000"),
        RoomInfo(id: 2, title: "Deluxe Room", price: "Rp150.000"),
        RoomInfo(id: 3, title: "Executive Suite", price: "Rp200.000"),
        RoomInfo(id: 4, title: "Presidential Suite", price: "Rp350.000")
    ]) {
        self.rooms = rooms
    }

    var body: some View {
        HofuCard {
            VStack(alignment: .leading) {
                Text("Rooms")
                    .style(.textSm(.semiBold))
                    .padding(.bottom, 8)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(rooms) { room in
                            RoomCard(info: room)
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        }
    }
}

struct RoomInfo: Identifiable {
    let id: Int
    let title: String
    let price: String
    let image: String
    let amenities: [String]

    init(
        id: Int,
        title: String,
        price: String,
        image: String = "Sakura",
        amenities: [String] = ["ic_tv_outline", "ic_double_bed_outline", "ic_refrigerator_outline"]
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.image = image
        self.amenities = amenities
    }
}

struct RoomCard: View {
    let info: RoomInfo
    @State private var isShowingSheetDetailRoom: Bool = false

    init(info: RoomInfo) {
        self.info = info
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image(info.image)
                .resizable()
                .scaledToFit()
                .frame(width: 148, height: 148)
                .cornerRadius(CGFloat(28))

            VStack(alignment: .leading) {
                Text(info.title)
                    .style(.textXs(.semiBold))
                    .foregroundStyle(.gray600)
                    .padding(.bottom, 2)
                Text(info.price)
                    .style(.textXss(.regular))
                    .foregroundStyle(.gray900)
                    .padding(.bottom, 4)
                HStack(spacing: 2) {
                    ForEach(info.amenities, id: \.self) { amenity in
                        Image(amenity)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.yellow)
                    }
                    if info.amenities.count > 3 {
                        Text("+\(info.amenities.count - 3)")
                            .style(.textXs(.regular))
                    }
                }.padding(.bottom, 12)
            }
            .padding(.horizontal, 12)
        }
        .onTapGesture {
            isShowingSheetDetailRoom = true
        }
        .frame(width: 148)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(.gray200, lineWidth: 1)
        )
        .sheet(isPresented: $isShowingSheetDetailRoom) {
            RoomDetailView(roomInfo: info, isShowingSheetDetailRoom: $isShowingSheetDetailRoom)
                .presentationDragIndicator(.visible)
        }
    }
}




#Preview("Hotel Rooms Card") {
    HotelRoomsCard()
}

#Preview("Room Detail Sheet View") {
    @Previewable @State var isShowingSheetDetailRoom = false
    RoomDetailView(
        roomInfo: RoomInfo(
            id: 1, title: "test", price: "100.000.000"
        ), isShowingSheetDetailRoom: $isShowingSheetDetailRoom
    )
}

#Preview("Product Detail Sheet View") {
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

#Preview("Date Picker Sheet View") {
    @Previewable @State var isShowingSheetDetailRoom = false
    RoomBookingDateView(isShowingSheetDetailRoom: $isShowingSheetDetailRoom)
}
