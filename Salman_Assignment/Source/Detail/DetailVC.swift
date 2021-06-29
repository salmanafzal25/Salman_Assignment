//
//  DetailVC.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    lazy  var viewModel:DetailViewModel = {
        let vm = DetailViewModel()
        vm.delegate = self
        return vm
    }()
    
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Detail"
        viewModel.getMovieDetail(id: id)
    }
    
    
    @IBAction func btnWatchTrailerAction(_ sender: Any) {
        let vc = PlayerVC.instantiateMain()
        vc.id = id
        self.present(vc, animated: true)
    }
    
}


extension DetailVC : DetailViewModelDelegate {
    
    func didReceiveError(error: String) {
        //Show Error Message from API
    }
    
    func didGetMoviesDetail() {
        guard let data =  viewModel.movieDetail else {return}
        lblDate.text = data.releaseDate
        lblOverview.text = data.overview
        
        if let imagePath =  data.backdropPath{
            let url = APIPath.imageURL + imagePath
            imgMovie.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.movie"))
        }
        
        lblMovieName.text = data.originalTitle
        if let generes = data.genres{
            lblGenres.text = generes.compactMap({$0.name}).joined(separator: ", ")
        }
    }
    
}
