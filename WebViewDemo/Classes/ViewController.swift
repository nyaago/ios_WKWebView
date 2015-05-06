//
//  ViewController.swift
//  WebViewDemo
//
//  Created by nyaago on 2015/05/06.
//  Copyright (c) 2015年 nyaago. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  
    var webView: WKWebView?
    var webConfigulation: WKWebViewConfiguration?
    var URL: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let configulation = getWKConfigulation()
        createWebView(configulation)
        view.addSubview(webView!)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        webView?.frame = view.bounds
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let urlRequest = NSURLRequest(URL: URL ?? NSURL(string: "http://www.google.com" )!)
        webView?.loadRequest(urlRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    // WKNavigationDelegate
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // Private
    
    private func getWKPreferences() -> WKPreferences {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = false
        return preferences
    }
    
    private func getWKConfigulation() -> WKWebViewConfiguration {
        if webConfigulation == nil {
            let preferences = getWKPreferences()
            webConfigulation = WKWebViewConfiguration()
            webConfigulation?.preferences = preferences
        }
        return webConfigulation!
    }
    
    private func createWebView(configulation: WKWebViewConfiguration) -> WKWebView {
        if(webView == nil) {
            webView = WKWebView(frame: view.bounds, configuration: configulation)
        }
        if let theWebView  = webView {
            theWebView.navigationDelegate = self
        }
        return webView!
  
    }
}
