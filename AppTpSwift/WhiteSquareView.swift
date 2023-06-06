//
//  WhiteSquareView.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 04/04/2023.
//

import Foundation
import SwiftUI

struct WhiteSquareView: View {
    let text: String
    let posterLink: String?
    @State private var toggleSheet = false
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 130, height: 200)
            .foregroundColor(Color.white)
            .overlay(content: {
                AsyncImage(url: URL(string: "\(imagesUrlPrefix)\(posterLink ?? "")")) { phase in
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
                                
                        } else {                                              ProgressView()
                            .font(.largeTitle)
                        }
                }
            })
    }
}
