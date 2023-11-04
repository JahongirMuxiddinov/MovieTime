//
//  HomePageVC.swift
//  MovieTime
//
//  Created by JAHONGIR on 06/09/23.
//

import UIKit
import Alamofire

class HomePageVC: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    var modelTrending: TrendingMoviesModel?
    var modelTV: TVDayModel?
    var modelMoving: MovingDayModel?
    var modelRated: TopRatedModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        setupTableView()

    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "HomePageCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomePageCell")
    }

    func getTrendingMovies() {
        guard let url = URL(string: URLS.TRENDING_MOVIES.self) else { return }

        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: TrendingMoviesModel.self) { response in

            LoadingOverlay.shared.hideOverlayView()

            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.modelTrending = data

                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? HomePageCell {
                    cell.updateCell(data.results)
                }


            case .failure(let error) : print(error, "ERROR")

            }
        }
    }

    func getTVDay() {
        
        guard let url = URL(string: URLS.TV_DAY.self) else { return }

        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: TVDayModel.self) { response in

            LoadingOverlay.shared.hideOverlayView()

            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.modelTV = data

                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? HomePageCell {
                    cell.updateCell(data.results)
                }

            case .failure(let error) : print(error, "ERROR")

            }
        }
    }

    func getMovingDay() {
        guard let url = URL(string: URLS.MOVING_DAY.self) else { return }

        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: MovingDayModel.self) { response in

            LoadingOverlay.shared.hideOverlayView()

            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.modelMoving = data

                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? HomePageCell {
                    cell.updateCell(data.results)
                }

            case .failure(let error) : print(error, "ERROR")

            }
        }
    }

    func getTopRated() {
        guard let url = URL(string: URLS.TOP_RATED.self) else { return }

        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: TopRatedModel.self) { response in

            LoadingOverlay.shared.hideOverlayView()

            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.modelRated = data

                if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? HomePageCell {
                    cell.updateCell(data.results)
                }

            case .failure(let error) : print(error, "ERROR")

            }
        }
    }


}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1:
            getTrendingMovies()
        case 2:
            getTVDay()
        case 3:
            getMovingDay()
        case 4:
            getTopRated()
        default: break
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as! HomePageCell
            cell.collectionView.backgroundColor = .clear
            cell.containerView.backgroundColor = UIColor(patternImage: UIImage(named: "avengers")!)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageCell", for: indexPath) as! HomePageCell
    
            
            cell.didSelectAction = { index, originalTitle, overview in
                guard let url = URL(string: URLS.YoutubeBaseURL) else { return }
                
                let param: Parameters = [
                    "q": originalTitle,
                    "p": overview,
                    "key": URLS.YoutubeAPI_KEY
                ]
                
                LoadingOverlay.shared.showoverlay(view: self.view)
                
                AF.request(url, parameters: param).responseDecodable(of: TizerModel.self) { data in
                    
                    LoadingOverlay.shared.hideOverlayView()
                    
                    switch data.result {
                    case .success(let result):
                        print(result, "RESULT")
                        
                        if let r = result.items, r.count > 0 {
                            let vc = TizersVC(nibName: "TizersVC", bundle: nil)
                            vc.url = r[0].id?.videoID ?? ""
                            vc.labelTitle = originalTitle
                            vc.textViewInfo = overview
                            print(originalTitle, " originaltitle ")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    case .failure(let error): print(error, "ERROR")
                    }
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var tt: String = ""
        if section == 1 {
        tt = "Trending Movies"
        }
       else if section == 2 {
            tt = "TV Day"
        }
       else if section == 3 {
            tt = "Moving Day"
        }
        else if section == 4 {
            tt = "Top Rated"
        }
        return tt
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        if indexPath.section == 0 {
            height = 450
        }
        else {
            height = 180
        }
        return CGFloat(height)
    }
}
