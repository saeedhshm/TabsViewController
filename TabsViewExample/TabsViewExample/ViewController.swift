//
//  ViewController.swift
//  TabsViewExample
//
//  Created by InterTeleco on 4/19/18.
//  Copyright © 2018 InterTeleco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tabsView: TabsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabsView.headerTitles = [
           "first vc","second vc","third vc"
        ]
        let str = UIStoryboard(name: "Main", bundle: nil);
        let first = str.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
        let second = str.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        let third = str.instantiateViewController(withIdentifier: "ThirdVC") as! ThirdVC
        
        tabsView.viewControllers = [
           first,second,third
        ]
        
        
    }

}

