//
//  Api.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 04/04/2023.
//

import Foundation

let apiKey = "56e674cbce6fa4a0cebcc75917bb8925"

let baseUrl = "https://api.themoviedb.org/3"

let language = "fr-FR"

let url = URL(string: "\(baseUrl)/movie/100?api_key=\(apiKey)&language=\(language)")!

let fetchGenreUrl = URL(string: "\(baseUrl)/genre/movie/list?api_key=\(apiKey)&language=\(language)")!
let fetchDisneyMoviesUrl = URL(string:"\(baseUrl)/discover/movie?api_key=\(apiKey)&language=\(language)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_companies=6125&with_watch_monetization_types=flatrate&language=\(language)")!

let fetchPopularUrl = URL(string: "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=\(language)&page=1")!

let fetchTopRatedMovie = URL(string: "\(baseUrl)/movie/top_rated?api_key=\(apiKey)&language=\(language)&page=1")!

let fetchTrendingUrl = URL(string: "\(baseUrl)/trending/movie/day?api_key=\(apiKey)&language=\(language)")!

let imagesUrlPrefix = "https://image.tmdb.org/t/p/w500"

let backdropImagesUrlPrefix = "https://image.tmdb.org/t/p/original"

struct MovieModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let release_date: String
    let tagline: String?
    let poster_path: String
    let backdrop_path: String
    let genre_ids: [Int]
}

struct GenreModel: Decodable {
    let genres: [Genre]
}
    
struct Genre: Decodable {
    let id: Int
    let name: String
}

class FetchMovies: ObservableObject {
    @Published var disneyMovies = [Movie]()
    @Published var popularMovies = [Movie]()
    @Published var topRatedMovies = [Movie]()
    @Published var trendingMovies = [Movie]()
    
    func getDisneyMovies() {
        let url = fetchDisneyMoviesUrl
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data!)
                DispatchQueue.main.async {
                    self.disneyMovies = movies.results
                }
            }
            catch {
                print("Error while fetching", error)
            }
        }
        .resume()
    }


    func getPopularMovies() {
        let url = fetchPopularUrl
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data!)
                DispatchQueue.main.async {
                    self.popularMovies = movies.results
                }
            }
            catch {
                print("Error while fetching", error)
            }
        }
        .resume()
    }
    
    func getTopRatedMovies() {
        let url = fetchTopRatedMovie
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data!)
                DispatchQueue.main.async {
                    self.topRatedMovies = movies.results
                }
            }
            catch {
                print("Error while fetching", error)
            }
        }
        .resume()
    }
    
    func getTrendingMovies() {
        let url = fetchTrendingUrl
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let movies = try JSONDecoder().decode(MovieModel.self, from: data!)
                DispatchQueue.main.async {
                    self.trendingMovies = movies.results
                }
            }
            catch {
                print("Error while fetching", error)
            }
        }
        .resume()
    }
}
