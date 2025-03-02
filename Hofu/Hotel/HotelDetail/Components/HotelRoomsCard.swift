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
    @State private var isShowingSheet: Bool = false

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
            isShowingSheet = true
        }
        .frame(width: 148)
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(.gray200, lineWidth: 1)
        )
        .sheet(isPresented: $isShowingSheet) {
            RoomDetailSheetView(roomInfo: info)
                .presentationDragIndicator(.visible)
        }
    }
}

struct RoomDetailSheetView: View {
    let roomInfo: RoomInfo

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    RoomDetailView(roomInfo: roomInfo)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                        
                    ShopView()
                        .padding(.horizontal, 16)
                }
                .padding(.top, 24)
                .scrollIndicators(.hidden)
                    .safeAreaInset(edge: .bottom) {
                        BookingFooter(price: roomInfo.price)
                    }
            }

            .background(.gray50)
        }
    }
}

struct RoomDetailView: View {
    let roomInfo: RoomInfo

    var body: some View {
        VStack {
            HofuCard {
                // Room image
                HStack {
                    Image(roomInfo.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .cornerRadius(24)
                    VStack(alignment: .leading) {
                        // Room name
                        Text(roomInfo.title)
                            .style(.displayXs(.semiBold))
                            .padding(.bottom, 4)

                        // Description
                        Text("A luxurious suite with stunning city views, perfect for relaxation and comfort.")
                            .style(.textSm())
                            .foregroundStyle(.gray500)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }.padding(.bottom, 8)

            HofuCard {
                HStack {
                    Spacer()
                    // Room features
                    RoomFeatures()
                    Spacer()
                }
            }
        }
    }
}

struct RoomFeatures: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                FeatureItem(
                    icon: "ic_star",
                    text: "5.0 Rating",
                    color: .warning400
                )
                FeatureItem(
                    icon: "ic_wifi_outline",
                    text: "Free Wi-Fi",
                    color: .gray600
                )
                FeatureItem(
                    icon: "ic_sunrise_outline",
                    text: "Breakfast Included",
                    color: .gray600
                )
            }
            Text("See all amenities")
                .style(.textSm(.semiBold))
                .foregroundStyle(.brand600)
        }
    }
}

struct FeatureItem: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundStyle(color)
            Text(text)
                .style(.textSm())
        }
    }
}

struct BookingFooter: View {
    let price: String

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text(price)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("/per night")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            HofuButton(
                title: "Book Now",
                onPressed: { print("Book now pressed") },
                isFullWidth: true
            )
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .border(width: 2, edges: [.top], color: .gray100)
        .background(.gray25)
    }
}

// MARK: - Shop View Components

struct ShopView: View {
    @State private var searchQuery = ""
    @State private var isSheetPresented = false
    @State private var isListView = false

    let products: [ProductItemInfo]

    init(
        products: [ProductItemInfo] = (0 ..< 6).map {
            ProductItemInfo(
                id: $0,
                title: "Product \($0 + 1)",
                price: "Rp\($0 * 100_000)",
                description: "This is a detailed description of Product \($0 + 1).",
                rating: Double.random(in: 3.0 ... 5.0),
                imageName: "Sakura"
            )
        }
    ) {
        self.products = products
    }

    var body: some View {
        HofuCard {
            VStack(spacing: 16) {
                // ShopSearchBar(
                //     searchQuery: $searchQuery,
                //     isSheetPresented: $isSheetPresented,
                //     isListView: $isListView
                // ).padding(.bottom, 8)

                HStack {
                    Text("Hofu Shop Exclusive")
                        .style(.textSm(.semiBold))
                    Spacer()
                }

                LazyVGrid(
                    columns: isListView ? [GridItem(.flexible())] : [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 16
                ) {
                    ForEach(products) { product in
                        NavigationLink(
                            destination: ProductDetailSheetView(product: product)
                        ) {
                            ProductItem(info: product, isListView: isListView)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
                HofuOutlineButton(title: "See more products", onPressed: {})
            }
        }
    }
}

struct ProductDetailSheetView: View {
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

struct ShopSearchBar: View {
    @Binding var searchQuery: String
    @Binding var isSheetPresented: Bool
    @Binding var isListView: Bool

    var body: some View {
        HStack {
            HofuTextField(
                placeholder: "Search items...",
                text: $searchQuery,
                leadingIcon: Image("ic_search_outline"),
                onLeadingIconTap: { print("Search tapped") },
                onTrailingIconTap: { print("Trailing tapped") },
                onChange: { text in
                    print("Search query: \(text)")
                }
            )

            Spacer()

            HStack {
                FilterButton(isSheetPresented: $isSheetPresented)
                ViewToggleButton(isListView: $isListView)
            }
        }
    }
}

struct FilterButton: View {
    @Binding var isSheetPresented: Bool

    var body: some View {
        HofuCircleButton(icon: { Image("ic_filter_outline") })
            .sheet(isPresented: $isSheetPresented) {
                Text("filter here later")
                    .presentationDetents([.fraction(0.40)])
                    .presentationDragIndicator(.visible)
            }
    }
}

struct ViewToggleButton: View {
    @Binding var isListView: Bool

    var body: some View {
        HofuCircleButton(icon: { Image(isListView ? "ic_grid_outline" : "ic_list_outline") })
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isListView.toggle()
                }
            }
    }
}

struct ProductItemInfo: Identifiable {
    let id: Int
    let title: String
    let price: String
    let description: String
    let rating: Double
    let imageName: String
}

struct ProductItem: View {
    let info: ProductItemInfo
    let isListView: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image(info.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(28)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: isListView ? 400 : 200
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(info.title)
                    .style(.textMd(.semiBold))
                    .lineLimit(1)

                Text(info.price)
                    .style(.textSm(.semiBold))
                    .foregroundStyle(.gray500)

                Text(info.description)
                    .style(.textXs())
                    .foregroundStyle(.gray400)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image("ic_star")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.warning400)
                        .frame(width: 16, height: 16)

                    Text(String(format: "%.1f", info.rating))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }.padding(12)
                .frame(maxWidth: .infinity, alignment: isListView ? .leading : .center)
        }

        .background(Color.white)
        .cornerRadius(28)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview("Hotel Rooms Card") {
    HotelRoomsCard()
}

#Preview("Room Detail Sheet View") {
    RoomDetailSheetView(
        roomInfo: RoomInfo(id: 1, title: "test", price: "100.000.000")
    )
}

#Preview("Product Detail Sheet View") {
    ProductDetailSheetView(product:
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
