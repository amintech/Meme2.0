//
//  DetailViewController.swift
//  Meme2.0
//
//  Created by  AminSaleh on 14/03/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var showMemeImage: UIImageView!
    var memesImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let memeimage = memesImage {
            showMemeImage.image = memeimage
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
