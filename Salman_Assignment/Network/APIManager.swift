//
//  APIManager.swift
//  AlGhoneim(iOS)
//
//  Created by APPLE on 6/28/19.
//  Copyright © 2019 SalmanAfzal. All rights reserved.
//

import Foundation
import Alamofire


struct APIPath {
    static let BaseURL = "https://api.themoviedb.org/3/movie/"
    static let imageURL = "https://image.tmdb.org/t/p/w500/"
}

class APIManager{
    
    static func getPopularMovie(pageNumber: Int , completion: @escaping (CategoryResponseModel?) -> ()) {
        
        let  url =  "\(APIPath.BaseURL)popular?page=\(pageNumber)&api_key=\(ApiKey)"
        
        Alamofire.request(url).responseJSON
        { response in
            debugPrint(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    do {
                        let obj = try JSONDecoder().decode(CategoryResponseModel.self, from: response.data!)
                        completion(obj)
                    }catch{
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
        
    }
    
    
    
    static func getMovieDetail(videoId: Int , completion: @escaping (MovieDetailResponseModel?) -> ()) {
        
        let  url =  "\(APIPath.BaseURL)\(videoId)?api_key=\(ApiKey)"
        
        Alamofire.request(url).responseJSON
        { response in
            debugPrint(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    do {
                        let obj = try JSONDecoder().decode(MovieDetailResponseModel.self, from: response.data!)
                        completion(obj)
                    }catch{
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        
    }
    
    
    static func getTrailerUrl(videoId: Int , completion: @escaping (TrailerVideosResponseModel?) -> ()) {
        
        let  url =  "\(APIPath.BaseURL)\(videoId)/videos?api_key=\(ApiKey)"
        Alamofire.request(url).responseJSON
        { response in
            debugPrint(response)
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    do {
                        let obj = try JSONDecoder().decode(TrailerVideosResponseModel.self, from: response.data!)
                        completion(obj)
                    }catch{
                        completion(nil)
                    }
                default:
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
  
}





//List
//https://api.themoviedb.org/3/movie/popular?page=1&api_key=5b5b2f79e701e7b0722941d47d68a704

// Detail
//https://api.themoviedb.org/3/movie/775996?api_key=5b5b2f79e701e7b0722941d47d68a704


//Image URl
//https://image.tmdb.org/t/p/w500/


//Video
//https://api.themoviedb.org/3/movie/775996/videos?api_key=5b5b2f79e701e7b0722941d47d68a704
