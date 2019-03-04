//
//  TableViewController.swift
//  GestureDemo
//
//  Created by Syon on 05/02/19.
//  Copyright © 2019 Syon. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arr1 = ["one","two","three","four","five"]
    var arr2 = ["2one","2two","2three","2four","2five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLongPressGesture()
    }
    
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let touchPoint = gestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
//                print("Long pressed row: \(indexPath.row)")
                let alert = UIAlertController(title: "Copy", message: "Do you want to copy and paste?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    print("Long pressed row: \(indexPath.row)")
                    let object = self.arr1[indexPath.row]
                    let secObj = self.arr2[indexPath.row]
                    
                    self.arr1.insert("\(object)-copy", at: indexPath.row + 1)
                    self.arr2.insert("\(secObj)-copy", at: indexPath.row + 1)
                    self.tableView.reloadData()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
//    func copy(index: Int, object: String) {
//        if object.contains("-copy") {
//            
//        }
//        self.arr1.insert("\(object)-copy", at: index)
//    }

    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "Copy", message: "Do you want to copy and paste?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("COPY AND PASTE")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        cell.lblOne.text = arr1[indexPath.row]
        cell.lblTwo.text = arr2[indexPath.row]
        return cell
    }
    
}


