//
//  HomePageCell.swift
//  MovieTime
//
//  Created by JAHONGIR on 11/09/23.
//

import UIKit
import Alamofire
import SDWebImage

class HomePageCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var containerView: UIView!
    
    var Result: [GeneralResult] = []
    
    var didSelectAction: ((Int, String, String) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionCell")
    }
    
    func updateCell(_ arr: [GeneralResult]){
        Result = arr
        self.collectionView.reloadData()
    }
    
}

extension HomePageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Result.count
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell

    
    if let url = URL(string: URLS.IMAGE_HASH_ID + (Result[indexPath.row].posterPath ?? "")) {
        cell.collectionImg.sd_setImage(with: url)
    }
    
    return cell
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    0
}
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    0
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let didSelectAction {
            didSelectAction (indexPath.row,
                             Result[indexPath.row].originalTitle ?? "",
                             Result[indexPath.row].overview ?? "")
        }
        
    }
}

