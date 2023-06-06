//
//  ContentView.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 04/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet: Bool = false
    @State private var sheetSize: PresentationDetent = .medium
    @State private var currentMovie: Movie?
    @StateObject var fetchMovies = FetchMovies()
    
    var body: some View {
        ZStack(alignment: Alignment.top) {
            ScrollView {
                Text("DIMFLIX").foregroundColor(Color.red).bold().font(.system(size: 50))
                HorizontalMovieList(currentMovie: $currentMovie, showSheet: $showSheet, title: "Populaire", datas: fetchMovies.popularMovies)
                HorizontalMovieList(currentMovie: $currentMovie, showSheet: $showSheet, title: "Mieux notés", datas: fetchMovies.topRatedMovies)
                HorizontalMovieList(currentMovie: $currentMovie, showSheet: $showSheet, title: "Tendances", datas: fetchMovies.trendingMovies)
            }
        }.padding(.top, 45)
        .onAppear() {
            fetchMovies.getTopRatedMovies()
            fetchMovies.getPopularMovies()
            fetchMovies.getTrendingMovies()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.vertical)
        .sheet(isPresented: $showSheet, content: {
            NavigationView {
                VStack() {
                    SheetView(movie: currentMovie, sheetSize: $sheetSize)
                }.padding(.leading, 10).padding(.trailing, 10)
            }.frame(height: 9999).padding(.top, 75)
            Color.white
                .presentationDetents([sheetSize]).onDisappear() {
                    sheetSize = .medium
                }
        })
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
