//
//  ViewController.swift
//  DocuSketchTestTask
//
//  Created by Erik on 21.10.2023.
//

import UIKit
import SnapKit

class MainView: UIViewController {
    
    private var items = [String]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        makeConstraints()
        loadItemsFromUserDefaults()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "DocuSketchTestTask"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewTask))
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func saveItemsToUserDefaults() {
        UserDefaults.standard.set(items, forKey: "itemsKey")
    }
    
    func loadItemsFromUserDefaults() {
        if let savedItems = UserDefaults.standard.array(forKey: "itemsKey") as? [String] {
            items = savedItems
            tableView.reloadData() // Update the table view after loading the data
        }
    }
    
    @objc private func addNewTask() {
        let alert = UIAlertController(title: "New Task", message: "Add New Task", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter Your task"
            textField.autocapitalizationType = .sentences
        }
        let done = UIAlertAction(title: "Done", style: .default) { _ in
            self.items.append(alert.textFields![0].text ?? "Empty Items")
            self.saveItemsToUserDefaults()
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(done)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        if items.isEmpty {
            return cell
        }
        cell.configureCell(text: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            saveItemsToUserDefaults()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

