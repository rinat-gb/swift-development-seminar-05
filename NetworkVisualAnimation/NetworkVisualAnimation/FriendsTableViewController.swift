//
//  FriendsTableViewController.swift
//  NetworkVisualAnimation
//
//  Created by Ринат on 29.08.2023.
//

import UIKit

final class FriendTableViewController: UITableViewController {
    private var friendsModel: FriendsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.Titles.friendsTitle
        tableView.register(FriendCell.self, forCellReuseIdentifier: Constants.CellNames.friendsCellName)

        NetworkService().getFiends { [weak self] friendsModel in
            if friendsModel.response?.count == 0 {
                // а нету друзей! меняем заголовое на "Нет друзей"
                DispatchQueue.main.async {
                    self?.title = Constants.TitlesNoItems.friendsTitle
                }
            } else {
                self?.friendsModel = friendsModel

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
        return friendsModel?.response?.count ?? 0
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let friendCell =
            tableView.dequeueReusableCell(withIdentifier: Constants.CellNames.friendsCellName, for: indexPath) as? FriendCell
        else {
            return UITableViewCell()
        }
        guard let friend = friendsModel?.response?.items?[indexPath.row] else {
            return UITableViewCell()
        }
        friendCell.update(friend: friend)
        return friendCell
    }
}
