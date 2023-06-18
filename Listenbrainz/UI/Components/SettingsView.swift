//
//  SettingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/23.
//

import SwiftUI


struct SettingsView: View {
  @AppStorage("isDarkMode") private var isDarkMode = false

  @State private var userToken:String = ""

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
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

        })
      }
      .navigationBarTitle(Text("Settings"))
    }

  }
}
 

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
