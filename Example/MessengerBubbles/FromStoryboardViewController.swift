//
//  FromStoryboardViewController.swift
//  MessengerBubbles_Example
//
//  Created by Laurent Grondin on 28/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MessengerBubbles

class FromStoryboardViewController: UIViewController {

    deinit {
        print("FromStoryboardViewController deinit")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var onlineSwitch: UISwitch!
    private let reuseIdentifier = "FromStoryboardCell"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onlineSwitchValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
}

extension FromStoryboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FromStoryboardCell
        switch indexPath.row {
        case 0:
            cell.configure(with: User.dataSource.first, isOnline: onlineSwitch.isOn)
        default:
            cell.configure(with: Group.dataSource, isOnline: onlineSwitch.isOn)
        }
        return cell
    }
}
