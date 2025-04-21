//
//  SearchUsersView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 03/06/24.
//

import SwiftUI


struct SearchUsersView: View {
    @Binding var isSearchActive: Bool
    @State private var searchTerm: String = ""
    @StateObject private var searchViewModel = SearchViewModel(repository: SearchRepositoryImpl())
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var insetsHolder: InsetsHolder
    
    var body: some View {
        ZStack {
            theme.colorScheme.background
            
            VStack {
                
                HStack(alignment: .center) {
                    Button(
                        action: {
                            isSearchActive = false
                            searchTerm = ""
                            searchViewModel.clearSearch()
                        }
                    ) {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(theme.colorScheme.lbSignature)
                            .padding(.leading, 16)
                    }
                    .frame(alignment: .center)
                    
                    CustomSearchBar(text: $searchTerm, onSearchButtonClicked: {
                        searchViewModel.searchTerm = searchTerm
                    })
                }
                .padding(.top, insetsHolder.insets.top)
                .ignoresSafeArea(.keyboard)
                
                
                if let error = searchViewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                ScrollView(.vertical) {
                    VStack(spacing: 2) {
                        ForEach(searchViewModel.users) { user in
                            UserProfileView(user: user)
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    SearchUsersView(isSearchActive: .constant(false))
        .environmentObject(Theme())
}

