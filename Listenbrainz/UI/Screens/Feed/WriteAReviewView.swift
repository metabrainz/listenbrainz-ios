//
//  WriteAReviewView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 08/07/24.
//

import SwiftUI

struct WriteAReviewView<T: TrackMetadataProvider>: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @EnvironmentObject var theme: Theme
    
    @State private var text: String = ""
    @State private var rating: Int = 0
    @State private var language: String = "English"
    @State private var agreedToTerms: Bool = false
    @Binding var isPresented: Bool
    
    var item: T
    var userToken: String
    var userName: String
    var dismissAction: () -> Void

  var body: some View {

      VStack(alignment: .leading, spacing: 10) {
        HStack {
          Spacer()
          Image("critiquebrainz-logo")
            .resizable()
            .frame(width: 200, height: 30)
            .padding(.top, 5)
          Spacer()
        }
        .padding(.trailing, 10)

        Divider()

        HStack(spacing: 0) {
          Text("You are reviewing ")

          Text("\(item.trackName ?? "this track") ")
            .fontWeight(.bold)

          Text("for ")

          Text("CritiqueBrainz.")
                .foregroundColor(theme.colorScheme.lbSignature)
            .fontWeight(.bold)
            .onTapGesture {
              if let url = URL(string: "https://critiquebrainz.org") {
                UIApplication.shared.open(url)
              }
            }
        }
        .font(.subheadline)

        DismissableTextView(text: $text)
          .frame(height: 150)
          .padding(.vertical, 5)

        HStack {
          Text("Rating (optional):")
            .padding(.top, 5)
            .foregroundColor(theme.colorScheme.text)

          StarRatingView(rating: $rating)
            .padding(.vertical, 5)
        }

        HStack {
          Text("Language of your review:")
            .padding(.top, 5)
            .foregroundColor(theme.colorScheme.text)

          Picker("Select Language", selection: $language) {
            ForEach(["English", "Spanish", "French", "German", "Chinese"], id: \.self) { lang in
              Text(lang)
                    .tag(lang)
                    .foregroundColor(theme.colorScheme.text)
            }
          }
          .pickerStyle(MenuPickerStyle())
          .padding(.vertical, 5)
        }

        Toggle(isOn: $agreedToTerms) {
          Text("You acknowledge and agree that your contributed reviews to CritiqueBrainz are licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license. You agree to license your work under this license. You represent and warrant that you own or control all rights in and to the work, that nothing in the work infringes the rights of any third-party, and that you have the permission to use and to license the work under the selected Creative Commons license. Finally, you give the MetaBrainz Foundation permission to license this content for commercial use outside of Creative Commons licenses in order to support the operations of the organization.")
            .font(.system(size: 10))
            .foregroundColor(theme.colorScheme.text)
        }
        .toggleStyle(CheckboxToggleStyle())
        .padding(.vertical, 5)

        HStack{
          Spacer()
          Button(action: {
            if agreedToTerms {
              writeReview()
              dismissAction()
            } else {
              print("User must agree to the terms")
            }
          }) {
            Text("Submit Review To CritiqueBrainz")
              .background(agreedToTerms ? Color.green : Color.yimGreen)
              .foregroundColor(.white)
          }
          .disabled(!agreedToTerms)
        }
      }
      .padding(.trailing)
    }


    private func writeReview() {
        guard let recordingMsid = item.recordingMsid else {
            print("Missing recording MSID")
            return
        }
        viewModel.writeAReview(
            userName: userName,
            item: item,
            userToken: userToken,
            entityName: item.trackName ?? "Unknown",
            entityId: recordingMsid,
            entityType: "recording",
            text: text,
            language: language,
            rating: rating
        )
    }
}


struct StarRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}



