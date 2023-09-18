//
//  SettingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/23.
//

import SwiftUI


struct SettingsView: View {
  @AppStorage("isDarkMode") private var isDarkMode = false
  @AppStorage("userToken") private var userToken:String = ""
  @AppStorage("userName") private var userName:String = ""
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var homeViewModel: HomeViewModel
  @EnvironmentObject var feedViewModel: FeedViewModel
  

  var body: some View  {
    NavigationView {
      Form{
        Section(header: Text("Turn On Dark Mode"),
                content: {
          HStack{
            Toggle("Dark Mode", isOn: $isDarkMode)
          }
        })
        Section(header: Text("Enter User Token"),
                footer: Text("Enter User Token from https://listenbrainz.org/profile/"),
                content: {
          TextField("Enter User Token", text: $userToken)
        })
        Section(header: Text("Enter User Name"),
                content: {
          TextField("Enter User Name", text: $userName)
        })
      }
      .navigationBarItems(
          trailing: Button(action: {
            homeViewModel.requestMusicData(userName: userName)
            feedViewModel.fetchFeedEvents(username: userName, userToken: userToken)
            dismiss()
          }, label: {
              Text("Save")
          }))
          .navigationBarTitle(Text("Settings"))
    }

  }

}
 

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//
//    }
//}
