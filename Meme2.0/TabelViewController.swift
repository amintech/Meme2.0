//
//  TabelViewController.swift
//  Meme2.0
//
//  Created by  AminSaleh on 13/03/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [ViewController.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    //let test = ["amin", "saleh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(memes.count)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    }

extension TableViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = "\(meme.topText) , \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = memes[(indexPath as NSIndexPath).row]
        let memeImage = meme.memedImage
        let detailView = self.storyboard!.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        detailView.memesImage = memeImage
        self.navigationController!.pushViewController(detailView, animated: true)
        
    }
    
}
