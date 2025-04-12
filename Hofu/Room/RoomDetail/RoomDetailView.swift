//
//  RoomDetailView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomDetailView: View {
    let roomInfo: RoomInfo
    @Binding var isShowingSheetDetailRoom: Bool
    @State private var isShowingDatePickerSheet: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    RoomDetailHeaderView(roomInfo: roomInfo)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)

                    RoomFeaturesView()
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)

                    RoomShopView()
                        .padding(.horizontal, 16)
                }
                .padding(.top, 24)
                .scrollIndicators(.hidden)
                .safeAreaInset(edge: .bottom) {
                    RoomBookNowFooterView(
                        price: roomInfo.price, onBookNow: {
                            isShowingDatePickerSheet = true
                        }
                    )
                }
            }

            .background(.gray50)
            .sheet(isPresented: $isShowingDatePickerSheet) {
                RoomBookingDateView(
                    isShowingSheetDetailRoom: $isShowingSheetDetailRoom
                )
            }
        }
    }
}

#Preview("Room Detail View") {
    @Previewable @State var isShowingSheetDetailRoom = false
    RoomDetailView(
        roomInfo: RoomInfo(
            id: 1, title: "test", price: "100.000.000"
        ), isShowingSheetDetailRoom: $isShowingSheetDetailRoom
    )
}

#Preview("Room Detail Header View") {
    RoomDetailHeaderView(
        roomInfo: RoomInfo(id: 1, title: "Title Room", price: "1000000")
    )
}

#Preview("Room Features View") {
    RoomFeaturesView()
}

#Preview("Room Product Detail View") {
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

#Preview("Room Booking View") {
    @Previewable @State var isShowingSheetDetailRoom = false
    RoomBookingDateView(isShowingSheetDetailRoom: $isShowingSheetDetailRoom)
}
