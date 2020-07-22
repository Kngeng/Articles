//
//  ArticleDetailsViewController.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = article.data.title
        handleThumbnailImage()
        if let url = URL(string: article.data.url) {
            let request = URLRequest(url : url)
            webview.navigationDelegate = self
            webview.load(request)
        }
        
    }
    
    func handleThumbnailImage() {
        guard article.data.thumbnail != "self" else {
            thumbnailImageView.image = nil
            imageViewHeightConstraint.constant = 0
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            Service.getImage(for: self.article.data.thumbnail, completion: { result in
                DispatchQueue.main.async {
                    if case .success(let image) = result {
                        self.thumbnailImageView.image = image
                        self.imageViewHeightConstraint.constant = (image.size.height/image.size.width) * self.thumbnailImageView.bounds.width
                    }
                }
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ArticleDetailsViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {}
    
    //webViewDidStartLoad
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {}
    
    //webViewDidFinishLoad
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    //didFailLoadWithError
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {}
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {}
}
