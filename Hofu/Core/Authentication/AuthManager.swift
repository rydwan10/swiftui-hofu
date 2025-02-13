//
//  AuthManager.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 19/01/25.
//

import SwiftUI

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userToken: String? = nil

    private let tokenKey = "userToken"
//    private let routeManager: RouteManager

    init() {
//        self.routeManager = routeManager
        loadToken()
    }

    // Login
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Simulasi API Call
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let mockToken = "mockToken123"
            DispatchQueue.main.async {
                self.userToken = mockToken
                self.isAuthenticated = true
                self.saveToken()

                // Navigasi ke halaman Home setelah login berhasil
//                self.routeManager.navigate(to: .home)

                completion(true)
            }
        }
    }

    // Logout
    func logout() {
        userToken = nil
        isAuthenticated = false
        deleteToken()

        // Reset rute dan navigasi ke halaman login
//        routeManager.popToRoot()
//        routeManager.navigate(to: .profile(username: "Login"))
    }

    // Refresh Token
    func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let _ = userToken else {
            completion(false)
            return
        }

        // Simulasi API Refresh Token
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let newMockToken = "newMockToken123"
            DispatchQueue.main.async {
                self.userToken = newMockToken
                self.saveToken()
                completion(true)
            }
        }
    }

    // Token Management
    private func saveToken() {
        if let token = userToken {
            UserDefaults.standard.set(token, forKey: tokenKey)
        }
    }

    private func loadToken() {
        if let token = UserDefaults.standard.string(forKey: tokenKey) {
            userToken = token
            isAuthenticated = true
        }
    }

    private func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
