//
//  MovieCell.swift
//  MovieTime
//
//  Created by JAHONGIR on 07/09/23.
//

import UIKit
import SDWebImage


class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieNameLbl: UILabel!
    
    @IBOutlet weak var playBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.selectionStyle = .none
        movieNameLbl.numberOfLines = 3
        playBtn.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(movieName: String?, imgUrl: String?) {
        movieNameLbl.text = movieName
        let url =  URL(string: URLS.IMAGE_HASH_ID + (imgUrl ?? ""))
        movieImage.sd_setImage(with: url)
    }
    

    
    @IBAction func playBtnPressed(_ sender: Any) {
    }
}
