//
//  PlayerViewModel.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import Foundation

protocol PlayerViewModelDelegate {
    func didReceiveError(error:String)
    func didGetMoviesDetail()
}

class PlayerViewModel {
    
    var delegate:PlayerViewModelDelegate!
    
    var movieTrailer: TrailerVideosResponseModel? = nil
    
    func getMovieDetail(id : Int) {
        ActivityIndicator.shared.showLoadingIndicator()
        APIManager.getTrailerUrl(videoId: id) { [self] res in
            ActivityIndicator.shared.hideLoadingIndicator()
        
            guard let data = res else{
                self.delegate.didReceiveError(error: "No Data...")
                return
            }
            self.movieTrailer = data
            self.delegate.didGetMoviesDetail()
        }
    }
    
}
