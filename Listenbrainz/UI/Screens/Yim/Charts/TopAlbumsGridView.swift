//
//  TopAlbumsGridView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct CoverArtGridView: View {
    @ObservedObject var viewModel: YIMViewModel

  var body: some View {
    let displayedReleaseGroups = viewModel.topReleaseGroups.prefix(11)

    ZStack{
      Rectangle()
        .foregroundColor(.clear)
        .frame(height: UIScreen.main.bounds.height)
        .background(Color.yimGreen)

      VStack {
        TopYimView(viewModel: viewModel)
          .padding(.top,30)
        Spacer()
        HStack(spacing:-30) {
          Image("curtainL")
            .resizable()
            .frame(width:80, height:260)
            .zIndex(1.5)


          VStack(spacing: 0) {

            ForEach(0..<3) { j in
              HStack(spacing: 0) {
                ForEach(0..<3) { i in
                  if let releaseGroup = displayedReleaseGroups[safe: (j * 3) + i],
                     let caaReleaseMbid = releaseGroup.caaReleaseMbid,
                     let caaID = releaseGroup.caaID,
                     let coverArtURL = makeCoverArtURL(caaReleaseMbid: caaReleaseMbid, caaID: caaID) {
                    CoverArtView(url: coverArtURL)
                      .aspectRatio(contentMode: .fill)
                      .frame(width: 80, height: 80)
                  }
                   else {

                    Image(systemName: "photo.fill")
                      .resizable()
                      .frame(width: 80, height: 80)
                  }
                }
              }
            }
          }
          Image("curtain2R")
            .resizable()
            .frame(width:80, height:260)
            .zIndex(1.5)


        }
        Spacer()
        Text("my top albums".uppercased())
          .font(.system(size: 25, weight: .bold))
          .tracking(18)
          .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))

        Spacer()


        Image("share")
        .frame(width: 49, height: 49)
        .padding(.trailing,250)
        .padding(.bottom,40)



        BottomYimView()

          .padding(.bottom,30)
//                .onAppear {
//                    viewModel.fetchYIMData(userName: "theflash_")
//              }
      }
    }
  }


    private func makeCoverArtURL(caaReleaseMbid: String, caaID: Int) -> URL? {
        
        guard !caaReleaseMbid.isEmpty, caaID > 0 else {
            return nil
        }

        return URL(string: "https://coverartarchive.org/release/\(caaReleaseMbid)/\(caaID)-250.jpg")
    }
}

struct CoverArtView: View {
    let url: URL

  var body: some View {
      AsyncImage(url: url) { phase in
          switch phase {

          case .success(let image):
              image
                  .resizable()
                  .frame(width: 100, height: 100)
          default:
              ProgressView()
                  .frame(width: 100, height: 100)
          }
      }
  }

    init(url: URL) {
        self.url = url
    }
}



extension TopReleaseGroup: Hashable {
    static func == (lhs: TopReleaseGroup, rhs: TopReleaseGroup) -> Bool {
        
        return lhs.caaReleaseMbid == rhs.caaReleaseMbid && lhs.caaID == rhs.caaID
    }

    func hash(into hasher: inout Hasher) {
        // Implement hashing based on your requirements
        hasher.combine(caaReleaseMbid)
        hasher.combine(caaID)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


struct CoverArtGridView_Previews: PreviewProvider {
    static var previews: some View {
      let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        CoverArtGridView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)

    }
}

