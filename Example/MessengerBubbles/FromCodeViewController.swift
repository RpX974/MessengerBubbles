//
//  ViewController.swift
//  MessengerBubbles
//
//  Created by Laurent Grondin on 06/28/2019.
//  Copyright (c) 2019 Laurent Grondin. All rights reserved.
//

import UIKit
import MessengerBubbles

class FromCodeViewController: UIViewController {

    deinit {
        print("FromCodeViewController deinit")
    }

    // MARK: - Views

    private lazy var onlineSwitch: UISwitch = {
        let _switch = UISwitch()
        _switch.addTarget(self, action: #selector(self.onlineSwitchValueChanged(sender:)), for: .valueChanged)
        return _switch
    }()
    private lazy var onlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Online"
        return label
    }()
    private lazy var onlineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.onlineLabel, self.onlineSwitch])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FromCodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()

    // MARK: - Properties

    private let reuseIdentifier = "FromCodeCell"
    
    // MARK: - Initializers
    
    var _title: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView
            .addTo(self.view)
            .vFillSuperview()
        onlineStackView
            .addTo(self.view)
            .vAnchor(top: nil, leading: nil, bottom: self.view.bottomAnchor, trailing: nil,
                    padding: .init(top: 0, left: 0, bottom: 30, right: 0))
            .centerXToSuperview()
    }

    // MARK: - IBAction

    @objc private func onlineSwitchValueChanged(sender: UISwitch) {
        tableView.reloadData()
    }
}

// MARK: - Extensions
// MARK: - TableView

extension FromCodeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FromCodeCell
        switch indexPath.row {
        case 0:
            cell.configure(with: User.dataSource.first, isOnline: onlineSwitch.isOn)
        default:
            cell.configure(with: Group.dataSource, isOnline: onlineSwitch.isOn)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - String

extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
}
