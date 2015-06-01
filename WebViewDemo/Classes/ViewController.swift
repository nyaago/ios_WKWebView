//
//  ViewController.swift
//  WebViewDemo
//
//  Created by nyaago on 2015/05/06.
//  Copyright (c) 2015年 nyaago. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {
  
    var webView: WKWebView?
    var webConfigulation: WKWebViewConfiguration?
    var URL: NSURL?
    var backToButton: UIBarButtonItem?
    var forwardToButton: UIBarButtonItem?
    var longPressBackGeatureRecognizer: UILongPressGestureRecognizer?
    var longPressForwardGeatureRecognizer: UILongPressGestureRecognizer?
    var tapBackGeatureRecognizer: UITapGestureRecognizer?
    var tapForwardGeatureRecognizer: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad")
        let configulation = getWKConfigulation()
        createWebView(configulation)
        view.addSubview(webView!)
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        webView?.frame = view.bounds
        if self.navigationController != nil {
            self.navigationController?.toolbarHidden = false
            addToolbarItems()
        }
        addNavigationbarItem()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let urlRequest = NSURLRequest(URL: URL ?? NSURL(string: "http://www.google.com" )!)
        webView?.loadRequest(urlRequest)
        addHistoryLongPressGestureHander()
        addTapGestureHander()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        NSLog("shouldRecognizeSimultaneouslyWithGestureRecognizer")
        return true
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
        backToButton?.enabled = webView.canGoBack
        forwardToButton?.enabled = webView.canGoForward
    }
    
    
    // Actions
    func backTo() {
        if webView?.canGoBack == true {
            webView?.goBack()
        }
    }

    func forwardTo() {
        if webView?.canGoForward == true {
            webView?.goForward()
        }
    }
    
    func refresh() {
        if webView?.URL! != nil {
            webView?.reload()
        }
    }
    
    func handleLongPressBackTo(sender: UILongPressGestureRecognizer) {
        NSLog("handleLongPressBackTo")
        showBackHistory()
    }

    func handleLongPressForwardTo(sender: UILongPressGestureRecognizer) {
        NSLog("handleLongPressForwardTo")
        showForwardHistory()
    }
    
    func handleTapBackTo(sender: UITapGestureRecognizer) {
        NSLog("handleTapBackTo")
        backTo()
    }
    
    func handleTapForwardTo(sender: UITapGestureRecognizer) {
        NSLog("handleTapForwardTo")
        forwardTo()
    }


    
    // Private
    private func showBackHistory() {
        
    }
    
    private func showForwardHistory() {
        
    }
    
    
    private func addHistoryLongPressGestureHander() {
        longPressBackGeatureRecognizer = UILongPressGestureRecognizer(
            target: self, action: "handleLongPressBackTo:")
        longPressForwardGeatureRecognizer = UILongPressGestureRecognizer(
            target: self, action: "handleLongPressForwardTo:")
        setAttributesToLongPressGestureRecognizer(
            longPressBackGeatureRecognizer)
        setAttributesToLongPressGestureRecognizer(
            longPressForwardGeatureRecognizer)
        viewForBarButtonItem(backToButton!).addGestureRecognizer(
            longPressBackGeatureRecognizer!)
        viewForBarButtonItem(forwardToButton!).addGestureRecognizer(
            longPressForwardGeatureRecognizer!)
        
    }

    private func addTapGestureHander() {
        tapBackGeatureRecognizer = UITapGestureRecognizer(
            target: self, action: Selector("handleTapBackTo:"))
        tapForwardGeatureRecognizer = UITapGestureRecognizer(
            target: self, action: Selector("handleTapForwardTo:"))
        setAttributesToTapGestureRecognizer(
            tapBackGeatureRecognizer)
        setAttributesToTapGestureRecognizer(
            tapForwardGeatureRecognizer)
        
        viewForBarButtonItem(backToButton!).addGestureRecognizer(
            tapBackGeatureRecognizer!)
        viewForBarButtonItem(forwardToButton!).addGestureRecognizer(
            tapForwardGeatureRecognizer!)
        viewForBarButtonItem(backToButton!).addGestureRecognizer(
            longPressBackGeatureRecognizer!)
        viewForBarButtonItem(forwardToButton!).addGestureRecognizer(
            longPressForwardGeatureRecognizer!)
//        self.navigationController?.toolbar.addGestureRecognizer(tapBackGeatureRecognizer!)
    }

    
    private func viewForBarButtonItem(barButtonItem: UIBarButtonItem) -> UIView {
        return barButtonItem.customView!
        
    }
    
    private func setAttributesToLongPressGestureRecognizer(
        longPressGestureRecognizer: UILongPressGestureRecognizer!) {
        
        longPressBackGeatureRecognizer?.numberOfTapsRequired = 1
        longPressBackGeatureRecognizer?.minimumPressDuration = 1
    }

    private func setAttributesToTapGestureRecognizer(
        tapGestureRecognizer: UITapGestureRecognizer!) {
            
            tapGestureRecognizer?.numberOfTapsRequired = 1
    }

    private func addToolbarItems() {

        var backButton: UIButton? = UIButton(frame: CGRectMake(0, 0, 40.0, 40.0))
        var backImage: UIImage? = UIImage(named: "arrow_left")
        backButton?.setImage(backImage!, forState:  UIControlState.Normal)
        backToButton = UIBarButtonItem(customView: backButton!)

        var forwardButton: UIButton? = UIButton(frame: CGRectMake(0, 0, 40.0, 40.0))
        var forwardImage: UIImage? = UIImage(named: "arrow_right")
        forwardButton?.setImage(forwardImage!, forState:  UIControlState.Normal)
        forwardToButton = UIBarButtonItem(customView: forwardButton!)

/*
        forwardToButton = UIBarButtonItem(title: ">",
            style: UIBarButtonItemStyle.Plain,
            target: nil,
            action: nil)

*/

        let fixedItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.FixedSpace,
            target: self,
            action: nil)

        self.toolbarItems = [backToButton!, fixedItem, forwardToButton!]
        return
    }
    
    private func addNavigationbarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Refresh,
            target: self,
            action: "refresh")
    }
    
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
    
    private func createWebView(configulation: WKWebViewConfiguration) -> WKWebView? {
        if(webView == nil) {
            webView = WKWebView(frame: view.bounds, configuration: configulation)
        }
        if let theWebView  = webView {
            theWebView.navigationDelegate = self
        }
        return webView
  
    }
    

}
