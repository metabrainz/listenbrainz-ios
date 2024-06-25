//
//  HomeView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//

import SwiftUI

struct HomeView : View{
  
  @State private var isSettingsPressed = false
  @State private var userToken: String = ""

  var body: some View{

    NavigationView{
      ScrollView{
        VStack(alignment: .center, spacing: 0){

          AdaptiveImage(
            light: Image("listenBrainzLight"),
            dark: Image("listenBrainzDark")
          )

          HStack(spacing: 0){
            Text("Listen")
              .foregroundColor(Color.secondary)

            Text("Brainz")
              .foregroundColor(Color.primary)

          }
          .font(.largeTitle)
          .fontWeight(.bold)
        }

        VStack(spacing: 10){
          HStack(alignment: .center, spacing: 0) {
            Image(systemName: "radio")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 65).cornerRadius(16)
              .foregroundColor(Color.primary)
              
            VStack(alignment: .leading, spacing: 8) {
              Text("Year in Music")
                .lineLimit(1)
                .font(.headline)

              Text("Your Whole Year Summarized")
            }
            .padding(.leading, 12)
            Spacer()
          }
          .padding(12)
          .background(Color.gray.opacity(0.15))


          HStack(alignment: .center, spacing: 0) {
            Image(systemName: "mic")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 65).cornerRadius(16)
              .foregroundColor(Color.primary)
            VStack(alignment: .leading, spacing: 8) {
              Text("News")
                .lineLimit(1)
                .font(.headline)

              Text("ListenBrainz News Updates")
            }
            .padding(.leading, 12)
            Spacer()
          }
          .padding(12)
          .background(Color.gray.opacity(0.15))
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {}) {
            Image("listenBrainzDark")
              .resizable()
              .frame(width: 40, height: 40)
              .padding(12)
              .cornerRadius(20)
              .clipShape(Circle())
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Text("ListenBrainz")
            .font(.system(size: 26))
            .fontWeight(.bold)
        }

        ToolbarItemGroup(placement: .navigationBarTrailing) {
          HStack{
            Button(action: {}) {
              Image(systemName: "info.circle")
            }
            Button(action: {}) {
              Image(systemName: "exclamationmark.circle")
            }
            Button(action: { self.isSettingsPressed = true }) {
              Image(systemName: "gear")
            }
          }
          .foregroundColor(Color.primary)
        }
      }
    }
    .sheet(isPresented: $isSettingsPressed) {
      SettingsView()
    }
  }
}


#Preview{
  HomeView()
}
