//
//  WebViewController.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlString: String?
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "WebView"
        self.activityIndicatorView?.stopAnimating()
        self.activityIndicatorView?.isHidden = true
        self.activityIndicatorView?.layer.zPosition = 200
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        if let url = URL(string: urlString ?? "") {
                webView.load(URLRequest(url: url))
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView?.isHidden = true
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView?.isHidden = false
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView?.isHidden = true
        if error._code == NSURLErrorCancelled {
            return
        }
    }
}
