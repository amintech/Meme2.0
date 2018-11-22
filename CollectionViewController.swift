//
//  CollectionViewController.swift
//  Meme2.0
//
//  Created by  AminSaleh on 13/03/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    /*
    var memes: [ViewController.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension CollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath)
        let meme = self.memes![(indexPath as NSIndexPath).row]
        
        //cell.textLabel?.text = "test"
        //cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
}
