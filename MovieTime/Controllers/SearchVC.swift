//
//  SearchVC.swift
//  MovieTime
//
//  Created by JAHONGIR on 07/09/23.
//

import UIKit
import Alamofire

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var model: MovingDayModel?
    
    var texts: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        initializeHideKeyboard()

        setupTableView()
        setupSearchBar()
    }


    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    func setupSearchBar() {
        searchBar.delegate = self

        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.clipsToBounds = true
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.backgroundColor = .clear
        searchBar.tintColor = .white
        searchBar.showsScopeBar = true
        
    }
    
    func getSearchingMovies(text: String) {
        guard let url = URL(string: URLS.SEARCH + text) else { return }
        
        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: MovingDayModel.self) { response in
            
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.model = data
                
            case .failure(let error) : print(error, "ERROR")
                
            }
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        cell.updateCell(movieName: model?.results[indexPath.row].title, imgUrl: model?.results[indexPath.row].posterPath )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.searchTextField.resignFirstResponder()

        
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.height/6)
    }
    
        
    
}

extension SearchVC {
    func initializeHideKeyboard(){
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(
           target: self,
           action: #selector(dismissMyKeyboard))
       
       tableView.addGestureRecognizer(tap)
   }
   
   @objc func dismissMyKeyboard(){
       
       print("initializeHideKeyboard")
       view.endEditing(true)
   }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1 {
            getSearchingMovies(text: searchText)
        }
        tableView.reloadData()
    }
    
}
