//
//  ViewController.swift
//  NetworkTest
//
//  Created by PaLiarMo on 26.05.2022.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var dataStorage = [JsonDataProtocol]()

    override func viewDidLoad() {
        super.viewDidLoad()
        retriveData()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func retriveData() {
        let urlString = "http://jsonplaceholder.typicode.com/posts"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("ЗАПРОС НЕУДАЛСЯ")
                return
            }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data) as? NSArray {
                    print("ОТВЕТ ВЕРНУЛСЯ")
                    for item in jsonResult {
                        if let itemDict = item as? NSDictionary{
                            let id  = itemDict["id"] as? Int ?? 0
                            let title  = itemDict["title"] as? String ?? ""
                            let userId  = itemDict["userId"] as? Int ?? 0
                            let body  = itemDict["body"] as? String ?? ""
                            self.dataStorage.append(myDataItem(id: id, title: title, userID: userId, body: body))
                            //print("Мы распарсили данные элемента массива:\n\n id = \(id)\n title = \(title)\n userId = \(userId)\n body = \(body)\n\n------------\n")
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
//            self.myTableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
//            self.myTableView.reloadData()
            
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
        task.resume()
    }

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStorage.count
    }
    
    private func configure(cell: inout MyTableViewCell, for indexPath: IndexPath) {
        cell.myNumber.text = String(indexPath.row)
        cell.myTitle.text = dataStorage[indexPath.row].title
        cell.myID.text = "ID - \(dataStorage[indexPath.row].id)"
        cell.myBody.text = dataStorage[indexPath.row].body
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if var cell = tableView.dequeueReusableCell(withIdentifier: "myCustomCell", for: indexPath) as? MyTableViewCell{
            configure(cell: &cell, for: indexPath)
            return cell
        } else { return UITableViewCell() }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: "Удалить"){ _,_,_ in
            self.dataStorage.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])

        return actions
    }
}
