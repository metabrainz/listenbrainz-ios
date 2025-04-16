//
//  LoginView.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 16/04/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    
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
                            if result != nil && error == nil {
                                userToken = result as! String
                                tokenFound = true
                            } else {
                                print("Failed to get token: \(String(describing: error?.localizedDescription))")
                                retriesLeft -= 1
                            }
                            
                            if (!tokenFound && retriesLeft > 0) {
                                // 1 second delay.
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    getToken()
                                }
                            } else {
                                dismiss()
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
