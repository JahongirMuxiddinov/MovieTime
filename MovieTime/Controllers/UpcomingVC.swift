//
//  UpcomingVC.swift
//  MovieTime
//
//  Created by JAHONGIR on 07/09/23.
//

import UIKit
import Alamofire

class UpcomingVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: UpComingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        setupTableView()
        getUpComingMovies()
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func getUpComingMovies() {
        guard let url = URL(string: URLS.UP_COMING.self) else { return }
        
        LoadingOverlay.shared.showoverlay(view: self.view)
        AF.request(url).responseDecodable(of: UpComingModel.self) { response in
            
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.model = data
                self.tableView.reloadData()
               
               
            case .failure(let error) : print(error, "ERROR")
                
            }
        }
    }
    
    
}

extension UpcomingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let result = model?.results[indexPath.row]
        
        cell.updateCell(movieName: result?.title, imgUrl: result?.posterPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.height/6)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
 
        
        guard let url = URL(string: URLS.YoutubeBaseURL) else { return }
        
        let param: Parameters = [
            "q": model?.results[indexPath.row].originalTitle ?? "",
            "key": URLS.YoutubeAPI_KEY
        ]
        
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url, parameters: param).responseDecodable(of: TizerModel.self) { data in
            
            LoadingOverlay.shared.hideOverlayView()
            
            switch data.result {
            case .success(let result):
                print(result, "RESULT")
                
                if let r = result.items, r.count > 0 {
                    let vc = TizersVC(nibName: "TizersVC", bundle: nil)
                    vc.url = r[0].id?.videoID ?? ""
                    vc.labelTitle = self.model?.results[indexPath.row].originalTitle ?? ""
                    vc.textViewInfo = self.model?.results[indexPath.row].overview ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error): print(error, "ERROR")
            }
        }
        
        
    }
    
}
