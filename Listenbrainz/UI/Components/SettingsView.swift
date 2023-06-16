//
//  SettingsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/23.
//

import SwiftUI


struct SettingsView: View {
@AppStorage("isDarkMode") private var isDarkMode = false


  
var body: some View  {
     NavigationView {
        List{
           HStack{
                 Toggle("Dark Mode", isOn: $isDarkMode)
               }
         }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
