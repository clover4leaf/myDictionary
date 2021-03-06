//
//  DefinitionsViewController.swift
//  MyDictionary
//
//  Created by Kirill on 4/10/19.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit
import RealmSwift

class DefinitionsViewController: UIViewController {

    // MARK: - Privates
    private var defArray = List<String>()

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Publics
    var word: Word?
//    var index = Int()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        let cellId = CustomTableViewCell.getStringName()
        tableView.register(UINib(nibName: cellId, bundle: nil),
                           forCellReuseIdentifier: cellId)

        defArray = word!.definitions // FORCE!!!

        setupUI()
    }

    // MARK: - Private functions
    @objc private func deleteAction() {
        guard let word = word else { return }
        AlertManager.alertDeleteWord(word: word, viewController: self) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    private func setupUI() {
        self.navigationItem.title = word?.word

        let deleteItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                         target: self,
                                         action: #selector(deleteAction))
        self.navigationItem.rightBarButtonItem = deleteItem

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundColor()

        self.view.backgroundColor = UIColor.backgroundColor()
    }

}

// MARK: - TableView
extension DefinitionsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return defArray.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = CustomTableViewCell.getStringName()

        if let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomTableViewCell {
            cell.configureCellWith(text: defArray[indexPath.row], fontSize: 17.0)
            cell.chooseColorForCell(index: indexPath.row)

            return cell
        }

        return UITableViewCell()
    }

}
