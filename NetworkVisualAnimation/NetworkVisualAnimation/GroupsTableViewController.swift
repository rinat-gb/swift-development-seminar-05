//
//  GroupsTableViewController.swift
//  NetworkVisualAnimation
//
//  Created by Ринат on 29.08.2023.
//

import UIKit

final class GroupsTableViewController: UITableViewController {
    private var groupsModel: GroupsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.Titles.groupsTitle
        tableView.register(GroupCell.self, forCellReuseIdentifier: Constants.CellNames.groupsCellName)

        NetworkService().getGroups { [weak self] groupsModel in
            if groupsModel.response?.count == 0 {
                // а нету групп! меняем заголовое на "Нет групп"
                DispatchQueue.main.async {
                    self?.title = Constants.TitlesNoItems.groupsTitle
                }
            } else {
                self?.groupsModel = groupsModel

                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    // ЗАКОММЕНТИРОВАНО ПО СРАВНЕНИЮ С КОДОМ ИЗ ДОМАШНЕГО ЗАДАНИЯ ПРЕДЫДУЩЕГО СЕМИНАРА
    //
    // нам необходимо отображать только одну секцию
    // если не задавать эту функцию, то уже существующая по умолчанию реализация в UIKit
    // возвращает как раз единицу и поэтому отдельно реалтзовывать функцию, возвращающую
    // единицу, нам не требуется.
    //
    // override func numberOfSections(in _: UITableView) -> Int {
    //     1
    // }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return groupsModel?.response?.count ?? 0
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupCell =
            tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.groupsCellName, for: indexPath) as? GroupCell
        else {
            return UITableViewCell()
        }
        guard let group = groupsModel?.response?.items?[indexPath.row] else {
            return UITableViewCell()
        }
        groupCell.update(group: group)
        return groupCell
    }
}
