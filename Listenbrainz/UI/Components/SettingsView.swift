//
//  SettingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/23.
//

import SwiftUI


struct SettingsView: View {
  @AppStorage(Strings.AppStorageKeys.isDarkMode) private var isDarkMode = true
  @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
  @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
  @Environment(\.dismiss) var dismiss


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
          dismiss()
        }, label: {
          Text("Save")
        }))
      .navigationBarTitle(Text("Settings"))
    }
    .preferredColorScheme(isDarkMode ? .dark : .light)
  }

}


struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()

  }
}
