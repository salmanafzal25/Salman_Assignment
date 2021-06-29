//
//  PlayerVC.swift
//  Salman_Assignment
//
//  Created by SalmanAfzal on 28/06/2021.
//

import UIKit
import youtube_ios_player_helper

class PlayerVC: UIViewController {

    @IBOutlet weak var player: YTPlayerView!
    
    lazy  var viewModel:PlayerViewModel = {
          let vm = PlayerViewModel()
          vm.delegate = self
          return vm
      }()
    
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getMovieDetail(id: id)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func playVideo(videoKey : String){
            let playerVars = [
                "controls": 1,
                "playsinline" : 1,
                "autoplay" : 1,
                "autohide" : 1,
                "rel" : 0
            ]
        
        player.delegate = self
        self.player.load(withVideoId: videoKey ,playerVars: playerVars) // "iwYhA5YvdNc" for testing
    }
    
}


extension PlayerVC: YTPlayerViewDelegate{
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        //If state == 1 => video is ended
        //If state == 2 => video is playing
        //If state == 3 => video is Paused

        if state.rawValue == 1 {
            self.dismiss(animated: true)
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        //for auto play video
        self.player.playVideo()
    }

}



extension PlayerVC : PlayerViewModelDelegate{
    func didReceiveError(error: String) {
        
    }
    
    func didGetMoviesDetail() {
        guard let data =  viewModel.movieTrailer else {return}
        
        DispatchQueue.main.async {
            self.playVideo(videoKey: data.results?.first?.key ?? "")
        }
        
    }
    
    
}
