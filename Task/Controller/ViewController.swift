//
//  ViewController.swift
//  Task
//
//  Created by Sagar Upadhyay on 19/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    let objMapDataParameters = MapDataParameters()
    var dataList = [DataStruct]()
    var isSearching:Bool?
    var searchResult:[Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarIntialisation()
        cellIntialisation()
        getData()
    }
    
    func cellIntialisation(){
        listCollectionView.register(UINib(nibName: "DataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DataCollectionViewCell")
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        updateUI(segmentController.selectedSegmentIndex)
    }
    
    func getData(){
        let url = "https://qapptemporary.s3.ap-south-1.amazonaws.com/test/synopsis.json"
        let parameters = ["": ""]
        print(parameters)
        print(url)
        requestGETURL(url, VC: self, params: parameters as [String : AnyObject], success:{ [self] (data)in
            print(data)
            objMapDataParameters.doInit(data)
            updateUI(segmentController.selectedSegmentIndex)
        }) { (error) in
            print(error)
        }
    }

    func updateUI(_ index:Int){
        dataList.removeAll()
        switch index {
        case 0:
            let list = objMapDataParameters.Long + objMapDataParameters.LongU + objMapDataParameters.short + objMapDataParameters.ShortC
            dataList = list.sorted(by: { (first, second) -> Bool in
                first.priceChange > second.priceChange
            })
            break
        
        case 1:
            dataList = objMapDataParameters.Long.sorted(by: { (first, second) -> Bool in
                first.priceChange > second.priceChange
            })
            break
            
        case 2:
            dataList = objMapDataParameters.ShortC.sorted(by: { (first, second) -> Bool in
                first.priceChange > second.priceChange
            })
            break
            
        case 3:
            dataList = objMapDataParameters.short.sorted(by: { (first, second) -> Bool in
                first.priceChange > second.priceChange
            })
            break
            
        case 4:
            dataList = objMapDataParameters.LongU.sorted(by: { (first, second) -> Bool in
                first.priceChange > second.priceChange
            })
            break
            
        default:
            break
        }
        searchBar.text = ""
        doneClick()
        isSearching = false
        searchResult?.removeAll()
        listCollectionView.reloadData()
    }
    
}


extension ViewController: UISearchBarDelegate,UIToolbarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText != ""{
                searchResult = dataList.indices.filter{dataList[$0].symbol.lowercased().contains(searchText.lowercased())}
                isSearching = true
            }else{
                isSearching = false
            }
        listCollectionView.reloadData()
    }
    
    @objc func doneClick()  {
        searchBar.resignFirstResponder()
    }
    
    func searchBarIntialisation(){
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        toolBar.delegate = self
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        searchBar.inputAccessoryView = toolBar
    }
    
}

//MARK:- SignUpProfileUserSelecation Collectionview Data Source
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if isSearching ?? false{
            return searchResult?.count ?? 0
        }else{
            return dataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCollectionViewCell", for: indexPath) as! DataCollectionViewCell
        if isSearching ?? false{
            cell.updateUI(dataList[searchResult?[indexPath.row] ?? 0])
        }else{
            cell.updateUI(dataList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width - 30) / 3, height: 100)
    }
    
}
