//
//  EVKBaseViewController.swift
//  iFeed
//
//  Created by Evgeny Karkan on 8/27/15.
//  Copyright (c) 2015 Evgeny Karkan. All rights reserved.
//

class EVKBaseViewController: UIViewController, UIAlertViewDelegate, EVKXMLParserProtocol {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title                            = "feeds"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    // MARK: - Public API - Alerts
    func showEnterFeedAlertView(feedURL: String) {
        let alertView = UIAlertView(
            title: "",
            message: "Add feed",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Add"
        )
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        
        let textField = alertView.textFieldAtIndex(0)!
        textField.placeholder = "http://www.something.com/rss"
        if !feedURL.isEmpty {
            textField.text = feedURL
        }
        
        alertView.show();
    }
    
    func alertViewCancel(alertView: UIAlertView) {
        alertView.endEditing(true)
    }
    
    /** click handler */
    func alertView(
        view: UIAlertView,
        didDismissWithButtonIndex buttonIndex: Int
    ) {
        if buttonIndex == 1 {
            if let textField = view.textFieldAtIndex(0) {
                if !textField.text!.isEmpty {
                    self.addFeedPressed(textField.text!)
                }
                else {
                    self.showInvalidRSSAlert()
                }
            }
        }
    }
    
    func showInvalidRSSAlert() {
        self.showAlertMessage("RSS feed can't be parsed")
    }
    
    func showDuplicateRSSAlert() {
        self.showAlertMessage("RSS feed already exists,\n try another one")
    }
    
    // MARK: - Public API - Add feed
    func addFeedPressed(URL: String) {
        //to override in sublasses
    }
    
    // MARK: - Public API - Parsing
    func startParsingURL(URL: String) {
        let parser            = EVKBrain.brain.parser
        parser.parserDelegate = self
        
        let url = NSURL(string: URL)
        
        if url != nil {
            parser.beginParseURL(NSURL(string: URL)!)
        }
        else {
            self.showInvalidRSSAlert()
        }
    }
    
    // MARK: - EVKXMLParserProtocol API
    func didEndParsingFeed(feed: Feed) {
        //to override in subclasses
    }
    
    func didFailParsingFeed() {
        self.showInvalidRSSAlert()
    }
    
    // MARK: - Common alert
    func showAlertMessage(message : String) {
        UIAlertView(
            title: "Oops...",
            message: message,
            delegate: nil,
            cancelButtonTitle: nil,
            otherButtonTitles: "Ok"
        ).show();
   }
}


