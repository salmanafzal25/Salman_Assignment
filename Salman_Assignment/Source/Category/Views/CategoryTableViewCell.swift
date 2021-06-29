//
//  CategoryTableViewCell.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import UIKit
import SDWebImage

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovie: UILabel!
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    static var identifier: String {
        return String(describing: self)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func loadCellData(data : Result){
        lblMovie.text = data.originalTitle
        
        if let imagePath =  data.posterPath{
            let url = APIPath.imageURL + imagePath
            imgMovie.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.movie"))
        }
    }
    
    
}
