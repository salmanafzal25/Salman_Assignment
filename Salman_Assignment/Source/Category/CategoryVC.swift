//
//  CategoryVC.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import UIKit
import Loaf

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchFieldBottomConstraint: NSLayoutConstraint!
    
    
    lazy  var viewModel:CategoryViewModel = {
        let vm = CategoryViewModel()
        vm.delegate = self
        return vm
    }()
    
    
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Category"
        searchBar.delegate = self
        
        registerTableviewCell()
        keyboardListner()
        
        if Reachability.isConnectedToNetwork(){
            viewModel.getMovies(pageNumber: currentPage)
        }else{
            Loaf("Internet Connection not Available!", state: .warning, location: .top, sender: self).show()
        }
    }
    
    func registerTableviewCell() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
}



//MARK:- TableView Functionality
extension CategoryVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesFilterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.loadCellData(data: viewModel.moviesFilterData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC.instantiateMain()
        vc.id = viewModel.moviesFilterData[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- Paging Functionality
extension CategoryVC {
    
    func getListFromServer(_ pageNumber: Int){
        viewModel.getMovies(pageNumber: currentPage)
    }
    
    func loadMoreItemsForList(){
        currentPage += 1
        getListFromServer(currentPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isSearching {return}
        view.endEditing(true)
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.loadMoreItemsForList()
        }
    }
}


//MARK:- API Response / Load Data
extension CategoryVC : CategoryViewModelDelegate{
    
    func didReceiveError(error: String) {
    }
    
    func didGetMoviesData() {
        self.isLoadingList = false
        viewModel.moviesFilterData =  viewModel.moviesData
        self.categoryTableView.reloadData()
    }
}


//MARK:- Search bar Functionality
extension CategoryVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            view.endEditing(true)
            viewModel.moviesFilterData =  viewModel.moviesData
        }else{
            isSearching = true
            viewModel.moviesFilterData.removeAll()
            for movie in viewModel.moviesData {
                if movie.originalTitle!.lowercased().contains(searchText.lowercased()) {
                    viewModel.moviesFilterData.append(movie)
                }
            }
        }
        self.categoryTableView.reloadData()
    }
    
}


//MARK:- Sticky Search Bar on top of keyboard Functionality
extension CategoryVC {
    
    func keyboardListner(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: Notification){
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.searchFieldBottomConstraint.constant = keyBoardHeight
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: Notification){
        self.searchFieldBottomConstraint.constant = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}



