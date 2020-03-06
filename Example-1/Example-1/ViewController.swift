//
//  ViewController.swift
//  Example-1
//
//  Created by Sergey Ryazanov on 06.03.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }

    func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    // MARK: - Download

    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        let dataTask = URLSession.shared.dataTask(with: url) {[weak cell] (data, response, error) in
            guard error == nil, let data = data else {
                cell?.imageView?.image = nil
                return
            }
            DispatchQueue.main.async {
                cell?.imageView?.image = UIImage(data: data)
                cell?.setNeedsLayout()
            }
        }
        dataTask.resume()
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row + 1)"

        let imageString = "http://placehold.it/375x150?text=\(indexPath.row + 1)"
        if let url = URL(string: imageString) {
            self.downloadImage(withURL: url, forCell: cell)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
