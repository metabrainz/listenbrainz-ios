//
//  UserDetailsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 04/12/23.
//


import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var theme: Theme
    
    // MARK: - PROPERTIES
    @AppStorage(Strings.AppStorageKeys.isOnboarding) var isOnboarding: Bool?
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("To sign in, use your MusicBrainz account, and authorize ListenBrainz to access your profile data.")
                    .multilineTextAlignment(.center)
                
                VStack {
                    Text("Important")
                        .font(.system(size: 24, weight: .medium, design: .default))
                        .foregroundStyle(Color.red.opacity(0.8))
                    
                    Spacer()
                    
                    Text("""
                         By signing into ListenBrainz, you grant the MetaBrainz Foundation permission to include your listening history in data dumps we make publicly available under the CC0 license. None of your private information from your user profile will be included in these data dumps.
                         
                         Furthermore, you grant the MetaBrainz Foundation permission to process your listening history and include it in new open source tools such as recommendation engines that the ListenBrainz project is building. For details on processing your listening history, please see our GDPR compliance statement.
                         
                         In order to combat spammers and to be able to contact our users in case something goes wrong with the listen submission process, we now require an email address when creating a ListenBrainz account.
                         
                         If after creating an account you change your mind about processing your listening history, you will need to delete your ListenBrainz account.
                         """
                    )
                    .multilineTextAlignment(.center)
                    
                }
                .padding()
                .border(theme.colorScheme.hint, cornerRadius: theme.sizes.cornerRadius)
                .background(Color.red.opacity(0.1))
                .cornerRadius(theme.sizes.cornerRadius)
                .padding(.vertical)
                
                Button {
                    showLoginView = true
                } label: {
                    Text("Sign in with MusicBrainz")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme.colorScheme.lbSignature)
                        .foregroundColor(theme.colorScheme.onLbSignature)
                        .cornerRadius(theme.sizes.cornerRadius)
                }
                
                Spacer()
            }
            .padding()
            .padding(.bottom)
        }
        .sheet(isPresented: $showLoginView) {
            LoginView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sign in")
                    .font(.system(size: 32, weight: .bold, design: .default))
            }
        }
    }
}

#Preview{
    UserDetailsView()
        .environmentObject(Theme())
}

