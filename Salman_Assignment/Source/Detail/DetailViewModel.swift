//
//  DetailViewModel.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import Foundation

protocol DetailViewModelDelegate {
    func didReceiveError(error:String)
    func didGetMoviesDetail()
}

class DetailViewModel {
    
    var delegate:DetailViewModelDelegate!
    var movieDetail: MovieDetailResponseModel? = nil
    
    func getMovieDetail(id : Int) {
        ActivityIndicator.shared.showLoadingIndicator()
        APIManager.getMovieDetail(videoId: id) { [self] res in
            ActivityIndicator.shared.hideLoadingIndicator()
        
            guard let data = res else{
                self.delegate.didReceiveError(error: "No Data...")
                return
            }
            
            self.movieDetail = data
            self.delegate.didGetMoviesDetail()
        }
    }
    
}
