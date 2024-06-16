//
//  SearchUsersView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 03/06/24.
//

import SwiftUI
import Combine

struct SearchUsersView: View {
  @Binding var isSearchActive: Bool
  @State private var searchTerm: String = ""
  @StateObject private var searchViewModel = SearchViewModel(repository: SearchRepositoryImpl())

  var body: some View {
    VStack {
      HStack {
        Button(action: {
          isSearchActive = false
          searchTerm = ""
          searchViewModel.clearSearch()
        }) {
          Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 20, height: 16)
            .foregroundColor(Color.primary)
            .padding(.leading)
        }

        TextField("Search users", text: $searchTerm, onCommit: {
          searchViewModel.searchTerm = searchTerm
        })
        .padding(.horizontal,10)
        .cornerRadius(12)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      .padding(.top,60)

      if let error = searchViewModel.error {
        Text(error)
          .foregroundColor(.red)
          .padding()
      }
      ScrollView(.vertical){
        VStack(spacing:2){
          ForEach(searchViewModel.users) { user in
            UserProfileView(user: user)
          }
        }
      }
    }
  }
}


struct SearchUsersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersView(isSearchActive: .constant(false))
    }
}
