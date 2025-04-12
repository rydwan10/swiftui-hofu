//
//  HotelList.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 12/01/25.
//

import SwiftUI

struct HotelListView: View {
    @State private var testText: String = ""
    @State private var isSheetPresented: Bool = false
    @State private var selectedFilter: HotelFilter = .priceHighToLow
    @EnvironmentObject private var routeManager: RouteManager
    @State private var isListView: Bool = false // State untuk mode grid atau list

    var body: some View {
        ScrollView {
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
                        .sheet(isPresented: $isSheetPresented) {
                            HotelListFilterView(
                                selectedFilter: $selectedFilter,
                                isSheetPresented: $isSheetPresented
                            )
                            .presentationDetents([.fraction(0.40)])
                            .presentationDragIndicator(.visible)
                        }.onTapGesture {
                            isSheetPresented.toggle()
                        }
                    HofuCircleButton(icon: { Image("ic_list_outline") })
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) { // Animasi transisi
                                isListView.toggle()
                            }
                        }
                }
            }.padding(.bottom)
            LazyVGrid(
                columns: isListView ? [GridItem(.flexible())] : [GridItem(.flexible()), GridItem(.flexible())],
                spacing: isListView ? 8 : 2
            ) {
                ForEach(1 ... 30, id: \.self) { index in
                    if isListView {
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
                    } else {
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
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Hotel")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .clipped()
        .padding()
        .background(.gray25)
    }
}

struct HotelListFilterView: View {
    @Binding var selectedFilter: HotelFilter
    @Binding var isSheetPresented: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("Filter Hotel")
                .style(.textLg(.semiBold))
                .padding(.bottom, 8)
                .padding(.top, 12)

            ForEach(HotelFilter.allCases, id: \.self) { filter in
                HStack {
                    // Radio Button
                    Circle()
                        .stroke(selectedFilter == filter ? .brand400 : .gray600, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .fill(.brand600)
                                .frame(width: 12, height: 12)
                                .opacity(selectedFilter == filter ? 1 : 0)
                        )

                    // Filter Title
                    Text(filter.displayName)
                        .style(.textMd(.regular))
                    // Icon
                    Image(systemName: filter.iconNameSystem)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.blue)
//                        .onAppear {
//                            if !UIImage(named: filter.iconName).isNil {
//                                // Menggunakan ikon khusus jika tersedia
//                                Image(filter.iconName)
//                            } else {
//                                // Menggunakan ikon sistem jika aset tidak ditemukan
//                                Image(systemName: filter.iconNameSystem)
//                            }
//                        }

                    Spacer()
                }.onTapGesture {
                    selectedFilter = filter
                    isSheetPresented = false
                }
                .padding(.vertical, 8)
            }
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

enum HotelFilter: String, CaseIterable {
    case priceHighToLow = "Price High to Low"
    case priceLowToHigh = "Price Low to High"
    case rating = "Rating"
    case distance = "Distance"

    var displayName: String {
        rawValue
    }

    var iconName: String {
        switch self {
        case .priceHighToLow: return "ic_price_high"
        case .priceLowToHigh: return "ic_price_low"
        case .rating: return "ic_star"
        case .distance: return "ic_location"
        }
    }

    var iconNameSystem: String {
        switch self {
        case .priceHighToLow: return "arrow.up"
        case .priceLowToHigh: return "arrow.down"
        case .rating: return "star"
        case .distance: return "location"
        }
    }
}

#Preview {
    @Previewable @State var isSheetPresented = false
    @Previewable @State var selectedFilter: HotelFilter = .priceHighToLow

    return HotelListFilterView(selectedFilter: $selectedFilter, isSheetPresented: $isSheetPresented)
        .padding()
}

#Preview {
    HotelListView().environmentObject(RouteManager())
}
