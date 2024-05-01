//
//  detailsViewController.swift
//  iosTestDemo
//
//  Created by vartika krishna on 01/05/24.
//

import UIKit

class detailsViewController: UIViewController {

    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    var id = Int()
    var userid = Int()
    var tTitle = String()
    var body = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performHeavyComputation()
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData(){
        
        lblId.text = "\(id)"
        lblUserId.text = "\(userid)"
        lblTitle.text = "\(tTitle)"
        lblBody.text = "\(body)"
    }
    func performHeavyComputation() {
        let startTime = DispatchTime.now()
      
        for _ in 0..<1000000 {
            // Some computation
           
        }
        
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000 // Time in seconds
        
        print("Time taken: \(timeInterval) seconds")
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
