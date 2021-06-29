//
//  CategoryViewModel.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import Foundation

protocol CategoryViewModelDelegate {
    func didReceiveError(error:String)
    func didGetMoviesData()
}

class CategoryViewModel {
    
    var delegate:CategoryViewModelDelegate!
    
    var moviesData = [Result]()
    var moviesFilterData = [Result]()
    
    func getMovies(pageNumber : Int) {
    
        ActivityIndicator.shared.showLoadingIndicator()
        APIManager.getPopularMovie(pageNumber: pageNumber) { [self] res in
            ActivityIndicator.shared.hideLoadingIndicator()
        
            guard let data = res?.results else{
                self.delegate.didReceiveError(error: "No Data...")
                return
            }
           
            self.moviesData.append(contentsOf: data)
            self.delegate.didGetMoviesData()
            
            
        }
    }
}
