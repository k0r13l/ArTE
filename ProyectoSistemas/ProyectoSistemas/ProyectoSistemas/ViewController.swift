//
//  ViewController.swift
//  ProyectoSistemas
//
//  Created by LABORATORIOS on 31/5/22.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(webView)
        
        guard let url = URL(string: "https://eeam55.000webhostapp.com/sistemas")else{
            return
        }
        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }


}

