//
//  TizersVC.swift
//  MovieTime
//
//  Created by JAHONGIR on 14/09/23.
//

import UIKit
import WebKit

class TizersVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var movieNameLbl: UILabel!
    
    @IBOutlet weak var movieInfo: UITextView!
    
    var url: String = ""
    
    var labelTitle: String = ""
    var textViewInfo: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieInfo.isUserInteractionEnabled = false
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        guard let url = URL(string: "https://www.youtube.com/embed/" + self.url) else { return }
        webView.load(URLRequest(url: url))
        
        movieNameLbl.text = labelTitle
        movieInfo.text = textViewInfo
    }


}

extension TizersVC: WKUIDelegate, WKNavigationDelegate {
    
}
