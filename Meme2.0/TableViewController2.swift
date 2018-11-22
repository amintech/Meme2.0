//
//  TableViewController.swift
//  Meme2.0
//
//  Created by  AminSaleh on 12/03/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [ViewController.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    let test = ["amin", "saleh", "mohammed"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
}

extension TableViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("test")
        return self.test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        let meme = self.test[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = meme
        //cell.imageView?.image = meme.memedImage
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
