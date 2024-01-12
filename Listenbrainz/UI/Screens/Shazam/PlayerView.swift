//
//  PlayerView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//



import SwiftUI
import ShazamKit

struct PlayerView: View {
  @State private var fileName = ""
  @State private var openFile = false
  @StateObject private var shazamViewModel: ShazamViewModel = .init()
  @State private var animateShazamButton = false
  @StateObject var viewModel: YIMViewModel

  var body: some View {
    content
      .sheet(item: $shazamViewModel.mediaItem) { mediaItem in
        MediaItemView(mediaItem: mediaItem)
      }
      .alert(isPresented: $shazamViewModel.hasError) {
        Alert(title: Text("Error"), message: Text(shazamViewModel.error?.localizedDescription ?? ""))
      }
  }

  @ViewBuilder
  var content: some View {
    if shazamViewModel.matching {
      ProgressView("Listening...")
        .tint(Color.primary)
        .foregroundColor(Color.secondary)
    } else {
      VStack(spacing: 20) {
        Spacer()

        Text("Tap icon to Shazam")
          .font(.largeTitle)

        Button(action: {
          animateShazamButton.toggle()
          shazam()
        }) {
          Image(systemName: "shazam.logo.fill")
            .resizable()
            .frame(width: 150, height: 150)
            .foregroundColor(Color.blue.opacity(0.8))
            .scaleEffect(animateShazamButton ? 0.9 : 1.0)
        }
        .onAppear {
          startAnimationTimer()
        }

        Button(action: {
          openFile.toggle()
        }, label: {
          Text("Import song")
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 35)
            .background(Color.secondary.opacity(0.7))
            .clipShape(Capsule())
        })

        Text(fileName)
          .foregroundColor(Color.primary)

        Button {
          if shazamViewModel.selectedAudioURL != nil {
            shazamViewModel.startMatching()
          }
        } label: {
          Text("Match")
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 35)
            .background(Color.primary.opacity(0.7))
            .clipShape(Capsule())
        }

        NavigationLink(destination: MainView(viewModel: viewModel)) {
          VStack {
            HStack {
              VStack(alignment: .leading) {
                Text("Year In Music")
                  .font(.headline)
                  .fontWeight(.bold)
                  .foregroundColor(Color.yimGreen)
                  .padding(.top)

                Text("Review")
                  .foregroundColor(Color.yimGreen)
              }
              Spacer()

              Image(systemName: "hands.sparkles")
                  .resizable()
                  .frame(width: 30, height: 30)
                  .colorMultiply(Color.yimGreen)

            }
            .padding(.horizontal)
            Spacer()

            VStack{
              Image("plant")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 92)
                .padding(.trailing,60)
                .padding(.bottom,-60)
              Image("2023Numeric")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 90)
            }
           Spacer()
          }
          .frame(width: UIScreen.main.bounds.size.width, height: 200)
          .background(Color.yimBeige)
          .cornerRadius(10)
          .shadow(radius: 10)
        }

        Spacer()
      }
      .fileImporter(isPresented: self.$openFile, allowedContentTypes: [.audio]) { result in
        do {
          let fileURL = try result.get()
          self.shazamViewModel.selectedAudioURL = fileURL
          self.fileName = fileURL.lastPathComponent
          print("Selected audio URL: \(fileURL)")
        } catch {
          print(error.localizedDescription)
        }

      }

    }
  }

  private func startAnimationTimer() {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
      withAnimation(.easeInOut(duration: 0.4)) {
        animateShazamButton.toggle()
      }
    }
  }

  func shazam() {
    shazamViewModel.start()
  }
}





struct DocumentManager: FileDocument {
  var url: String
  static var readableContentTypes: [UTType] { [.audio] }

  init(url: String)  {
    self.url = url
  }

  init(configuration: ReadConfiguration) throws {
    url = ""
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let file = try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
    return file
  }
}


