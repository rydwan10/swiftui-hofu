//
//  Hero.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

struct HomeHero: View {
    @State private var textInput: String = ""
    var body: some View {
        VStack {
            ZStack {
                Image("Sakura") // Gambar yang ada di xcassets
                    .resizable()
                    .frame(height: 390)
                    .clipShape(RoundedCorner(radius: 40, corners: [.bottomLeft, .bottomRight]))

                VStack {
                    Spacer().frame(height: 90)
                    HStack {
                        HofuLogo()
                        Spacer()
                        Image("ic_bell")
                            .renderingMode(.template)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                    }
                    .padding(.horizontal, 16)

//                    Spacer()/
                    HStack {
                        Text("\"Lorem Ipsum Dolor sit amet\"")
//                            .foregroundStyle(Color(hex: 0xffb7d7))
                            .foregroundStyle(.white)
                            .padding(.leading, 16)

                        Spacer()
                    }

                    Spacer()

                    HStack {
                        Image("ic_search_outline")
                            .renderingMode(.template)
                            .foregroundColor(Color(hex: 0xFEFEFE, opacity: 0.75))
                        TextField("", text: $textInput, prompt: Text("Sanur, Bali").foregroundStyle(Color(hex: 0xFFFFFF, opacity: 0.75)))
                    }
                    .padding(
                        EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16)
                    )
                    .background(Color(hex: 0xBBBBBB, opacity: 0.65))
                    .cornerRadius(9999)
                    .shadow(radius: 10)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                }
            }
//            .frame(height: 308)
//            .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    HomeHero()
}
