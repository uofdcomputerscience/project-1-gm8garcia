//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let images = [UIImage(named: ""), UIImage(named: "")]
    let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    var cellList = CellList(mercury: [])
    let imageService = ImageService()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: request) {(data, response, error) in
                self.cellList = try! JSONDecoder().decode(CellList.self, from: data!)
                print(self.cellList.mercury.count)
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
    }
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellList.mercury.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell")!
        let imageURL = URL(string: self.cellList.mercury[indexPath.item].url)
        let nameLabelText = self.cellList.mercury[indexPath.item].name
        let typeLabelText = self.cellList.mercury[indexPath.item].type
        if let photoCell = cell as? PhotoCell{
            imageService.getImage(url: imageURL!){ (image) -> Void in
                let photoImage = image
                DispatchQueue.main.async {
                    photoCell.cellImage.image = photoImage
                    photoCell.nameLabel.text = nameLabelText
                    photoCell.typeLabel.text = typeLabelText
                }
            }
        }
        return cell
    }
}
