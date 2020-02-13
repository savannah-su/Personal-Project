//
//  PreventPageViewController.swift
//  Personal Project
//
//  Created by Savannah Su on 2020/2/12.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class PreventPageViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var buttomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewButton: VerticalAlignedButton!
    @IBAction func bottomViewButton(_ sender: Any) {
        downButtomView()
    }
    @IBOutlet weak var bottomViewLabel: UILabel!
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButton(_ sender: Any) {
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let itemLabel = ["疫苗施打", "體內驅蟲", "體外驅蟲"]
    let itemImage = ["疫苗施打", "體內驅蟲", "體外驅蟲"]
    let selectedImage = ["疫苗施打-selected", "體內驅蟲-selected", "體外驅蟲-selected"]
    var itemCellStatus = [false, false, false]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.dataSource = self
//        tableView.delegate = self
        
        collectionView.allowsMultipleSelection = false
        
        bottomViewButton.isHidden = true
        
        tableView.separatorColor = .clear
        tableView.isHidden = true

        // Do any additional setup after loading the view.
    }
}

//extension PreventPageViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let cell = tableView.cellForRow(at: indexPath) as? NotiCell
//
//        if cell?.notiSwitch.isOn == true {
//            return 140
//        }
//
//        return 54
//
//    }
//}

extension PreventPageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Enter Cell", for: indexPath) as? EnterInfoCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
            
        case 0:
            cell.titleLabel.text = "藥劑名稱"
            cell.contentText.placeholder = "例：三合一疫苗、蚤不到"
            return cell
            
        case 1:
            cell.titleLabel.text = "施作時間"
            cell.contentText.placeholder = "選擇本次施作時間"
            return cell
            
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Noti Cell", for: indexPath) as? NotiCell else {
                return UITableViewCell()
            }
            return cell
    }


}
}

extension PreventPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 98, left: 51, bottom: 98, right: 51)
    }
}

extension PreventPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item Cell", for: indexPath) as? ReuseItemCell else { return UICollectionViewCell() }
        
        for index in 0 ... 2 {
            
            let index = indexPath.row
            cell.itemLabel.text = itemLabel[index]
            
            if itemCellStatus[index] {
                cell.image.image = UIImage(named: selectedImage[index])
            } else {
                cell.image.image = UIImage(named: itemImage[index])
            }
        }
        return cell
    }
}

extension PreventPageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        for index in 0 ..< itemCellStatus.count {
            
            if index == indexPath.row {
                itemCellStatus[index] = true
            } else {
                itemCellStatus[index] = false
            }
        }
        collectionView.reloadData()
        
        upButtomView()
 
        bottomViewLabel.isHidden = true
        tableView.isHidden = false
    }
    
    func upButtomView() {
        
        let move = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
            
            self.buttomViewConstraint.isActive = false
            self.buttomViewConstraint = self.bottomView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 5)
            self.buttomViewConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
        move.startAnimation()
        
        bottomViewButton.isHidden = false
    }
    
    func downButtomView() {
        
        let move = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            
            self.buttomViewConstraint.isActive = false
            self.buttomViewConstraint = self.bottomView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 304)
            self.buttomViewConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
        move.startAnimation()
        
        bottomViewButton.isHidden = true
        
    }
}
