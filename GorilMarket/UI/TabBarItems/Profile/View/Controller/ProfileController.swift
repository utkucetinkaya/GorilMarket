//
//  ProfileController.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 16.10.2023.
//

import UIKit

class ProfileController: UIViewController {

    // MARK: - UI Element
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var logOutButton: UIButton!
    @IBOutlet weak private var usernameLabel: UILabel!
    
    // MARK: - Properties
    let headers = ["Hesabım","Ayarlar","Yardım Merkezi"]
    let accounts = ["Siparişlerim", "Kuponlarım"]
    let morefeatures = ["Adreslerim","Ödeme Yöntemlerim"]
    let support = ["Müşteri Hizmetleri","Soru ve Taleplerim"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        setUI()
    }
    
    // MARK: - SetUI
    private func setUI() {
        logOutButton.setBorder(width: 1, color: UIColor.primaryColor ?? .clear)
        logOutButton.setCorner(radius: 10)
    }
    
    // MARK: - RegisterTableView
    private func registerTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HeaderTitleCell.nameOfClass, bundle: nil), forCellReuseIdentifier: HeaderTitleCell.nameOfClass)
    }
    
    // MARK: - IBAction
    @IBAction func logOutTapped(_ sender: Any) {
        ProfileViewModel.shared.logOut { success in
            if success {
                let alert = UIAlertController(title: "Dikkat!", message: "Çıkış yapmak istiyor musunuz?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "İptal", style: .cancel)
                alert.addAction(cancelAction)
                
                let yesAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                    
                    let vc = LoginController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
                
                alert.addAction(yesAction)
                self.present(alert, animated: true)
                
                print("Cikis Yapildi")
            } else {
                self.showAlert(title: "Çıkış Yapılamadı", message: "Lütfen tekrar deneyin.")
            }
        }
    }
}

// MARK: - UITableViewDelegate&DataSource
extension ProfileController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accounts.count
        case 1:
            return morefeatures.count
        case 2:
            return support.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTitleCell.nameOfClass, for: indexPath) as? HeaderTitleCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = accounts[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        case 1:
            cell.titleLabel.text = morefeatures[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.titleLabel.text = support[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTitleCell.nameOfClass) as? HeaderTitleCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = UIFont(name: "Poppins-Bold", size: 20)
        cell.backgroundColor = .white
        cell.contentView.backgroundColor = .white
        cell.titleLabel.text = headers[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 40
        case 2:
            return 40
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 20
        case 1:
            return 20
        case 2:
            return 20
        default:
            return 20
        }
    }
}
