//
//  SettingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/23.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var theme: Theme
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var showLoginView: Bool = false
    
    var body: some View  {
        NavigationView {
            Form {
                Section(header: Text("Theme")) {
                    Toggle("Dark Mode", isOn: $theme.isDarkMode)
                }
                
                Section(header: Text("User name")) {
                    Text(userName)
                        .foregroundStyle(theme.colorScheme.text)
                }
                
                if userToken.isEmpty {
                    Button("Login") {
                        showLoginView = !showLoginView
                    }
                } else {
                    Button("Logout") {
                        userToken = ""
                    }
                    .foregroundColor(Color.red)
                }
            }
            .sheet(isPresented: $showLoginView) {
                LoginView()
            }
            .navigationBarItems(
                trailing: Button(action: {
                    homeViewModel.requestMusicData(userName: userName)
                    dismiss()
                }, label: {
                    Text("Save")
                }))
            .navigationBarTitle(Text("Settings"))
        }
        .preferredColorScheme(theme.systemColorScheme)
    }
    
}

#Preview{
    SettingsView()
}
