//
//  SheetView.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 17/04/2023.
//

import Foundation
import SwiftUI

struct SheetView: View {
    let movie: Movie?
    @Binding var sheetSize: PresentationDetent
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "\(backdropImagesUrlPrefix)\(movie?.backdrop_path ?? "")")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(5)
                        .clipped()
                        .frame(width: 450, height: 500)
                        .overlay(
                            Rectangle()
                                .fill(Color.black.opacity(0.6))
                        )
                } else if phase.error != nil {
                    Text("Image invalid")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                } else {
                    ProgressView()
                        .font(.largeTitle)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    AsyncImage(url: URL(string: "\(imagesUrlPrefix)\(movie?.poster_path ?? "")")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 130, height: 200)
                                .cornerRadius(5)
                                .clipped()
                        } else if phase.error != nil {
                            Text("Image invalid")
                                .bold()
                                .font(.title)
                                .multilineTextAlignment(.center)
                            
                        } else {
                            ProgressView()
                                .font(.largeTitle)
                        }
                    }
                    Text(movie?.title ?? "").foregroundColor(Color.white).bold().font(.system(size: 36))
                }
                Text(movie?.tagline ?? "").foregroundColor(Color.white).bold().font(.system(size: 26))
                Text(movie?.overview ?? "").foregroundColor(Color.white).bold().font(.system(size: 16)).lineLimit(7)
                Button("Detail", action: {
                    sheetSize = .large
                }).padding(.top, 10)
            }.padding()
        }.clipped()
    }
}
