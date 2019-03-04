//
//  ViewController.swift
//  GestureDemo
//
//  Created by Syon on 04/02/19.
//  Copyright © 2019 Syon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        saveImageToDocDirectory()
        fetchImage()
    }

    @IBAction func draggableView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @IBAction func textFieldPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.blueView)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.blueView)
    }
    
    @IBAction func imageView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    // MARK: DOCUMENT DIRECTORY OPERTAIONS
    func saveImageToDocDirectory() {
       
        do {
            let docDir = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = docDir.appendingPathComponent("running.png")
            let image = UIImage(named: "running.png")
            if let imageData = image?.jpegData(compressionQuality: 0.5) {
                try imageData.write(to: fileUrl)
            }
            print("Path url: \(fileUrl)")
            
        } catch  {
            print(error)
        }
    }
    
    //get directory path
    func getDirectoryPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("running.png") {
            let filePath = pathComponent.path
            if fileManager.fileExists(atPath: filePath) {
                print("File aviable")
                return filePath
            } else {
                print("File Not available")
            }
            } else {
                print("File path not found")
            }
          return ""
        }
    
    // delete directory
    func deleteDocDirectory() {
        
    }
    
    // fetch image from directory
    func fetchImage() {
        let imagePath = self.getDirectoryPath()
        print("Image path: \(imagePath)")
    
        if fileManager.fileExists(atPath: imagePath) {
            // set image here
            self.imageView.image = UIImage(contentsOfFile: imagePath)
        } else {
            print("No image found")
        }
    }
    
}

