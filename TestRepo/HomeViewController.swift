//
//  HomeViewController.swift
//  vAadhaar
//
//  Created by reshma on 21/01/20.
//  Copyright © 2020 Reshma. All rights reserved.
//

import UIKit
enum HomeMenu: Int {
    case Users = 1, Reports,Attendance,AllocateWork,History
}
class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = [["icon": "book_appointment","title": "Book an Appointment"],["icon": "video_conference","title": "Virtual Consultation"]]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addNotificationButton()
collectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        // homeMenuApiCall()
        // Do any additional setup after loading the view.
    }

    func addNotificationButton() {
        let notificationBtn = UIButton.init(frame: CGRect(x:0,y:0,width:25,height:25))
        notificationBtn.setImage(#imageLiteral(resourceName: "notification"), for: .normal)
        notificationBtn.addTarget(self, action: #selector(notificationBtnTapped(sender:)), for: .touchUpInside)
        let notificationBtnItem = UIBarButtonItem.init(customView: notificationBtn)
        self.navigationItem.rightBarButtonItems = [notificationBtnItem]
    }
    @objc func notificationBtnTapped(sender: UIButton) {
    //  showAlert(message: "Coming Soon...")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {


    // MARK: - UICollectionViewDataSource protocol

    // tell the collection view how many cells to make

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       
      return UICollectionViewCell()
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.

        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 0.5
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim - 5, height: dim)
    }

    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        guard !(indexPath.item == 1) else {
           // showAlert(message: "Coming Soon...")
            return
        }
            
        let depVc = self.storyboard?.instantiateViewController(withIdentifier: "DepartmentVC")
        self.navigationController?.pushViewController(depVc!, animated: true)
    }
}


// MARK: Service API call
/*
extension HomeViewController {
    private func homeMenuApiCall() {
        guard  Reachability.isConnectedToNetwork() else {
            showAlert(message: noInternetMessage)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            RestApi.sharedInstance.postMethodWebService(baseUrl + homeMenuAPI, postData: HomeRequest().params, with: { (response) in
                DispatchQueue.main.async {
                    switch response {
                    case .failure(let msg):
                        self.showAlert(message: msg)
                    case  .error(let isAuthorized):
                        guard isAuthorized else {
                            self.showAlert(message: "Server Error")
                            return
                        }
                    // Make Authorization API
                    case .response(let resultDic): print("dicccc***** \(resultDic)")
                   let home = CodableJson<HomeResponse>().transformFromJSON(resultDic)
                    guard home!.status else {
                        self.showAlert(message: home?.message ?? "No Data found")
                        return
                    }
                    self.homeMenuDetails = home?.userdashboardDetails ?? []
                    guard !self.homeMenuDetails.isEmpty else { return}
                    self.tableView.reloadData()
                    }
                }
            })
        }
    }
}*/
