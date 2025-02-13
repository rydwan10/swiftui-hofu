//
//  HotelList.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 12/01/25.
//

import SwiftUI

struct HotelListView: View {
    @State private var testText: String = ""
    @EnvironmentObject private var routeManager: RouteManager
    @State private var isListView: Bool = false // State untuk mode grid atau list

    var body: some View {
        VStack {
            HStack {
                HofuTextField(
                    placeholder: "Search Hotel...",
                    text: $testText,
                    leadingIcon: Image("ic_search_outline"),
                    onLeadingIconTap: { print("Leading icon tapped") },
                    onTrailingIconTap: { print("Trailing icon tapped") },
                    onChange: { text in
                        print("Text changed: \(text)")
                    }
                )
                Spacer()
                HStack {
                    HofuCircleButton(icon: { Image("ic_filter_outline") })
                    HofuCircleButton(icon: { Image("ic_list_outline") })
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) { // Animasi transisi
                                isListView.toggle()
                            }
                        }
                }
            }.padding(.bottom)

            ScrollView {
                if isListView {
                    // Tampilan list
                    LazyVStack(spacing: 8) {
                        ForEach(1 ... 30, id: \.self) { index in
                            HotelCardList(
                                image: "Sakura",
                                title: "Hotel \(index)",
                                city: "City \(index)",
                                country: "Country \(index)",
                                startingPrice: Double(100_000),
                                rating: Double.random(in: 3.0 ... 5.0).rounded()
                            ).onTapGesture {
                                routeManager.navigate(to: .hotelDetail(id: index, name: "Hotel \(index)"))
                            }
                            .transition(.slide) // Efek transisi slide
                        }
                    }
                    .animation(.spring(), value: isListView) // Animasi untuk elemen dalam list
                } else {
                    // Tampilan grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(1 ... 30, id: \.self) { index in
                            HotelCardGrid(
                                image: "Sakura",
                                title: "Hotel \(index)",
                                city: "City \(index)",
                                country: "Country \(index)",
                                isHaveShop: index % 2 == 0,
                                isHofuPartner: index % 3 == 0,
                                startingPrice: Double(100_000),
                                rating: Double.random(in: 3.0 ... 5.0).rounded()
                            ).onTapGesture {
                                routeManager.navigate(to: .hotelDetail(id: index, name: "Hotel \(index)"))
                            }
                            .transition(.scale) // Efek transisi scale
                        }
                    }
                    .animation(.spring(), value: isListView) // Animasi untuk elemen dalam grid
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        .background(.gray25)
    }
}

#Preview {
    HotelListView().environmentObject(RouteManager())
}
