//
//  VerticalList.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 04/04/2023.
//

import SwiftUI

struct HorizontalMovieList: View {
    @Binding var currentMovie: Movie?
    @Binding var showSheet: Bool
    let title: String
    let datas: [Movie?]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).foregroundColor(Color.white).bold().font(.system(size: 36))
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15, content: {
                    ForEach(datas, id: \.self) { data in
                        Button(action: {
                            showSheet.toggle()
                            currentMovie = data
                        }) {
                            WhiteSquareView(text: "\(data?.title ?? "Error")", posterLink: data?.poster_path)
                        }
                    }
                })
            }
        }.padding()
    }
}
