//
//  HomeCollectionCell.swift
//  MovieTime
//
//  Created by JAHONGIR on 11/09/23.
//

import UIKit
import SDWebImage

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var collectionImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCollectCell(imageUrl: String?) {
        let url =  URL(string: URLS.IMAGE_HASH_ID + (imageUrl ?? ""))
        collectionImg.sd_setImage(with: url)
    }

}
