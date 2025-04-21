//
//  LoginView.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 16/04/25.
//

import SwiftUI

struct LoginView: View {
    // We'll create a new instance as of now.
    private let dashboardRepository: DashboardRepository = DashboardRepositoryImpl()
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    @AppStorage(Strings.AppStorageKeys.isOnboarding) private var isOnboarding: Bool = false
    
    var body: some View {
        WebViewLB(
            url: URL(string: "https://listenbrainz.org/login/musicbrainz")!
        ) { webView in
            if (webView.url?.host() == "listenbrainz.org") {
                // Only navigate when on LB url.
                
                let path = webView.url?.path()
                if path?.contains("/settings") == true {
                    // Get auth token now.
                    var tokenFound: Bool = false
                    var retriesLeft: Int = 5
                    
                    func getToken() {
                        webView.evaluateJavaScript("document.getElementById('auth-token').value;") { (result, error) in
                            DispatchQueue.main.async {
                                func retryOrDismiss() {
                                    if !tokenFound && retriesLeft > 0 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            getToken()
                                        }
                                    } else {
                                        dismiss()
                                    }
                                }
                                
                                if let acquiredToken = result as? String, error == nil {
                                    // Async task lets go
                                    Task {
                                        var tokenValidation: TokenValidation? = nil
                                        do {
                                            tokenValidation = try await dashboardRepository.validateUserToken(userToken: acquiredToken)
                                        } catch {
                                            print("Token validation failed: \(error)")
                                            tokenValidation = nil
                                        }
                                        
                                        if tokenValidation?.valid == true {
                                            userToken = acquiredToken
                                            userName = tokenValidation!.username!
                                            
                                            isOnboarding = false
                                            tokenFound = true
                                        } else {
                                            print("Token validation failed: \(String(describing: tokenValidation?.message))")
                                            retriesLeft -= 1
                                        }
                                        
                                        retryOrDismiss()
                                    }
                                } else {
                                    print("Failed to get token: \(String(describing: error?.localizedDescription))")
                                    retriesLeft -= 1
                                    
                                    retryOrDismiss()
                                }
                            }
                        }
                    }
                    
                    // Start recursive call
                    getToken()
                } else {
                    // Navigate to settings page.
                    webView.load(
                        URLRequest(url: URL(string: "https://listenbrainz.org/settings")!)
                    )
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
