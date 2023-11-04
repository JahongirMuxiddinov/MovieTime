 import Foundation

class URLS {
    
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let IMAGE_HASH_ID = "https://image.tmdb.org/t/p/w500/"
   
    static let TRENDING_MOVIES = "\(BASE_URL)/3/trending/movie/day?api_key=\(API_KEY)"
    
    static let TV_DAY = "\(BASE_URL)/3/trending/tv/day?api_key=\(API_KEY)"
    
    static let UP_COMING = "\(BASE_URL)/3/movie/upcoming?api_key=\(API_KEY)&1anguage=en-US&page=1"
    
    static let MOVING_DAY = "\(BASE_URL)/3/movie/popular?api_key=\(API_KEY)&1anguage=en-US&page=1"

    static let TOP_RATED = "\(BASE_URL)/3/movie/top_rated?api_key=\(API_KEY)&1anguage=en-US&page=1"
    
    static let SEARCH = "\(BASE_URL)/3/search/movie?api_key=\(API_KEY)&query="

    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
    
}
