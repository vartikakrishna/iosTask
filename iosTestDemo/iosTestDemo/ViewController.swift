//
//  ViewController.swift
//  iosTestDemo
//
//  Created by vartika krishna on 01/05/24.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var currentPage = 1
    var totalPages = 1
    let refreshControl = UIRefreshControl()
    var repository = [mainModelName]()
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var pictureInfo = [mainModelName]() {
        didSet{
            DispatchQueue.main.async {
               // self.setcollectiomView()
                CacheManager.shared.cacheArrayData(array: self.pictureInfo, key: "cachedArrayKey")
                self.itemTableView.reloadData()
                print(self.pictureInfo[0].id)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadApiData()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        itemTableView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    @objc func loadData() {
        // Make network call to fetch data for currentPage
        loadApiData()
        currentPage += 1
        refreshControl.endRefreshing()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let cachedArray = CacheManager.shared.getArrayData(forKey: "cachedArrayKey") as? [mainModelName]
         return cachedArray?.count ?? 0
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "myTableCell", for: indexPath)
         let cell:myTableCell = tableView.dequeueReusableCell(withIdentifier: "myTableCell") as! myTableCell
         DispatchQueue.main.async {
             if let cachedArray = CacheManager.shared.getArrayData(forKey: "cachedArrayKey") as? [mainModelName] {
                 // Use the cached array
                 let ID = cachedArray[indexPath.row].id
                 let title = cachedArray[indexPath.row].title
                 cell.lblId.text = "id: \(ID)"
                 cell.lblTitle.text = "Title: \(title)"
               //  print("Cached array: \(cachedArray)")
             } else {
                 print("Array not found in cache")
             }
         }
        return cell
    }
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let cachedArray = CacheManager.shared.getArrayData(forKey: "cachedArrayKey") as? [mainModelName]
         if indexPath.row == (cachedArray?.count ?? 0) - 1, currentPage < totalPages {
            loadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cachedArray = CacheManager.shared.getArrayData(forKey: "cachedArrayKey") as? [mainModelName] 
            // Use the cached array
        let ID = cachedArray?[indexPath.row].id
        let userID = cachedArray?[indexPath.row].userId
        let title = cachedArray?[indexPath.row].title
        let body = cachedArray?[indexPath.row].body
            let destinationVC = storyboard?.instantiateViewController(withIdentifier: "detailsViewController") as? detailsViewController
        destinationVC?.id = ID ?? 0
        destinationVC?.userid = userID ?? 0
        destinationVC?.tTitle = title ?? ""
        destinationVC?.body = body ?? "0"
navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    func loadApiData()
    {
        let address = "https://jsonplaceholder.typicode.com/posts"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    do{
                        let decoder = JSONDecoder()
                        let picInfo = try decoder.decode([mainModelName].self, from: data)
                        self.pictureInfo.append(contentsOf: picInfo)
                    }catch{
                        print(error)
                    }
                }
            }.resume()
        }
        
    }
}
