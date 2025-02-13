//
//  PathStore.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 19/01/25.
//

import SwiftUI

// Enum untuk mendefinisikan rute aplikasi
enum AppRoute: Codable, Hashable {
    case login
    case home
    case detail(id: Int)
    case profile(username: String)
    case settings
    case hotelList
    case hotelDetail(id: Int, name: String)
    case register

//    // Contoh rute bersarang jika diperlukan
//    case nested(NestedRoute)
//
//    enum NestedRoute: Hashable {
//        case subDetail(parentId: Int, childId: Int)
//        case deepLink(path: String)
//    }
}

// Kelas untuk menyimpan dan mengelola path
class RouteManager: ObservableObject {
    @Published var path: NavigationPath
//    {
//        didSet {
//            save()
//        }
//    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }

        path = NavigationPath()
    }

    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save path")
        }
    }

    // Metode tambahan untuk navigasi
    func navigate(to route: AppRoute, saveRoute: Bool = false) {
        path.append(route)
        if saveRoute {
            save()
        }
    }

    func navigateReplaceAll(to route: AppRoute) {
        path = NavigationPath([route])
    }

    func goBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
