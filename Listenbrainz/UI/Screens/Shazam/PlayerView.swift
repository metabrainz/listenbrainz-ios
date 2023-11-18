//
//  PlayerView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//


import SwiftUI
import ShazamKit

//extension SHMatchedMediaItem: Identifiable {
//
//    public var id: String {
//        shazamID ?? ""
//    }
//}

struct PlayerView: View {
  @State private var fileName = ""
  @State private var openFile = false
  @StateObject private var viewModel: ShazamViewModel = .init()
  @State private var animateShazamButton = false

    var body: some View {
        content
            .sheet(item: $viewModel.mediaItem) { mediaItem in
                MediaItemView(mediaItem: mediaItem)
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? ""))
            }
    }

    @ViewBuilder
  var content: some View {
    if viewModel.matching {
      ProgressView("Listening...")
        .tint(Color.color_1)
        .foregroundColor(Color.color_2)
    }
    else {
      VStack(spacing:40) {

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
                .background(Color.color_2.opacity(0.7))
                .clipShape(Capsule())
        })
        Text(fileName)
          .foregroundColor(Color.color_1)
        Button {
          if viewModel.selectedAudioURL != nil {
                 viewModel.startMatching()
             }
        } label: {
          Text("Match")
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 35)
            .background(Color.color_1.opacity(0.7))
            .clipShape(Capsule())
        }

      }
      .fileImporter(isPresented: self.$openFile, allowedContentTypes: [.audio]) { result in
          do {
              let fileURL = try result.get()
              self.viewModel.selectedAudioURL = fileURL
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
        viewModel.start()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
