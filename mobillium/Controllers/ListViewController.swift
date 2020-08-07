//
//  ViewController.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var searchView: UIView!

    @IBOutlet weak var searchViewBtn: UIView!
    @IBOutlet weak var searchViewCancelBtn: UIView!
    @IBOutlet weak var searchBoxView: UIView!

    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchIconNavBar: UIImageView!
    @IBOutlet weak var searchText: UITextField!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableviewSearch: UITableView!

    @IBOutlet weak var cancelText: UILabel!

    @IBOutlet weak var finderView: UIView!
    @IBOutlet weak var finderImage: UIImageView!
    @IBOutlet weak var finderText: UILabel!


    var searching:Bool = false

    var searchStartPoint:CGRect? = nil

    var upcomingData:DataResults? = nil
    var searchData:DataResults? = nil
    var nowplaying:DataResults? = nil

    private var finishedLoadingInitialTableCells = false
    private var finishedLoadingInitialTableCells_dataCheck = false

    lazy var workItem = WorkItem()






    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableviewSearch.delegate = self
        tableviewSearch.dataSource = self
        tableviewSearch.separatorStyle = .none
        tableView.separatorStyle = .none



        tableviewSearch.keyboardDismissMode = .onDrag

        searchView.alpha = 0
        searchBoxView.alpha = 0
        searchIcon.tint(color: UIColor(hexString: "8A8A8E"))
        searchIconNavBar.tint(color: UIColor(hexString: "8A8A8E"))


        generateClick(target: self, selector: #selector(searchBtnFnc), view: searchViewBtn)
        generateClick(target: self, selector: #selector(searchBtnFnc), view: searchViewCancelBtn)

        searchText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)




        getNowplaying()
        getUpcoming()
    }



    ///API

    func getNowplaying() {
        APIClient.getNowPlaying { (success, error, data) in
            //print(data)
            DispatchQueue.main.async {
                self.nowplaying = data
                self.tableView.reloadData()
                self.tableviewSearch.layoutIfNeeded()
                self.finishedLoadingInitialTableCells_dataCheck = true
            }

        }

    }

    func getUpcoming() {
        var page = 1
        if self.upcomingData != nil{
            page = (self.upcomingData?.page)! + 1
        }

        APIClient.getUpcoming(page: page) { (success, error, data) in
            DispatchQueue.main.async {
                if self.upcomingData == nil{
                    self.upcomingData = data
                }else{
                    self.upcomingData?.results?.append(contentsOf: (data?.results)!)
                    self.upcomingData?.page = data?.page

                }

                self.tableView.reloadData()
                self.tableviewSearch.layoutIfNeeded()
                self.finishedLoadingInitialTableCells_dataCheck = true
            }
        }


    }

    func getSearch() {
        var page = 1
        if self.searchData != nil{
            page = (self.searchData?.page)! + 1
        }

        APIClient.getSearch(searchText: searchText.text!,page: page) { (success, error, data) in
            //print(data)
            DispatchQueue.main.async {


                if data?.results?.count == 0{
                    self.finderView.isHidden = false
                    self.finderImage.image = UIImage(named: "FaceNotFound")

                    self.finderText.text = "Sonuç Bulunamadı "
                }else{

                    if self.searchData == nil{
                        self.finishedLoadingInitialTableCells = false
                        self.finishedLoadingInitialTableCells_dataCheck = true
                        self.searchData = data
                    }else{
                        self.searchData?.results?.append(contentsOf: (data?.results)!)
                        self.searchData?.page = data?.page

                    }

                    print("Page Count getSearch -> \(self.searchData?.total_pages)")
                    self.finderView.isHidden = true
                    self.tableviewSearch.reloadData()
                    self.tableviewSearch.layoutIfNeeded()

                }
            }
        }

    }

    ///API



    @objc func textFieldDidChange(_ textField: UITextField) {


        if textField.text?.count ?? 0 > 2{
            if textField.text != ""{

                finderImage.image = UIImage(named: "FileSearching")

                print("Searching...")
                print("Search Text : \(textField.text!)")



                let number = Int.random(in: 1 ..< 4)

                finderImage.image = UIImage(named: "FileSearching\(number)")

                finderText.text = "Sonuçlar Aranıyor..."

                //0.35 MORE FAST
                workItem.perform(after: 0.5) {

                    print("--Searched...")
                    print("--Searched Text : \(textField.text!)")




                    var searchText = textField.text!

                    if searchText != ""{
                        self.getSearch()
                    }else{
                        self.searchData = nil
                        self.tableviewSearch.reloadData()
                    }


                }

            }else{
                self.finderView.isHidden = false
                self.finderImage.image = UIImage(named: "FaceHappy")

                self.finderText.text = "Hangi Filmi Arıyorsunuz ?"
            }
        }else{
            self.finderView.isHidden = false
            self.finderImage.image = UIImage(named: "FaceHappy")

            self.finderText.text = "Hangi Filmi Arıyorsunuz ?"
        }



        if textField.text == "" && cancelText.text == "Sil"{

            self.cancelText.fadeTransition(0.3)
            self.cancelText.text = "Vazgeç"


        }else if cancelText.text == "Vazgeç"{

            self.cancelText.fadeTransition(0.3)
            self.cancelText.text = "Sil"


        }
    }

    @objc func searchBtnFnc(){


        if searchStartPoint == nil{
            searchStartPoint = self.searchBoxView.frame
        }



        if !searching{
            //Search Box Opening
            UIView.animate(withDuration: 0.4) {
                self.searchBoxView.alpha = 1.0
            }




            self.searchBoxView.frame.origin.x = searchViewBtn.frame.origin.x - 4

            UIView.animate(withDuration: 0.3) {
                
                self.searchBoxView.frame.origin.x = (self.searchStartPoint?.origin.x)!
                //self.searchBoxView.alpha = 1.0
                self.searchView.alpha = 1.0

                self.searchIconNavBar.alpha = 0.0

                self.searchText.text = ""
                self.searchText.becomeFirstResponder()
                self.searching = true
            }
        }else{
            //Search Box Closing

            if cancelText.text == "Sil"{
                searchText.text = ""

                self.cancelText.fadeTransition(0.3)
                self.cancelText.text = "Vazgeç"

                self.searchData = nil
                self.tableviewSearch.reloadData()

                self.finderView.isHidden = false
                self.finderImage.image = UIImage(named: "FaceHappy")

                self.finderText.text = "Hangi Filmi Arıyorsunuz ?"


            }else{



                UIView.animate(withDuration: 0.4) {
                    self.searchBoxView.alpha = 0.0
                }

                UIView.animate(withDuration: 0.3) {
                    self.searchBoxView.frame.origin.x = self.searchViewBtn.frame.origin.x - 4


                    self.searchView.alpha = 0.0

                    self.searchIconNavBar.alpha = 1.0

                    self.searchText.text = ""
                    self.cancelText.text = "Vazgeç"
                    self.searchText.resignFirstResponder()
                    self.searching = false
                    self.finishedLoadingInitialTableCells = true
                }
            }
        }


    }



    ///Tableview

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        if tableView == self.tableView{
            if self.nowplaying == nil{
                return 0 + (self.upcomingData?.results!.count ?? 0)
            }else{
                return 1 + (self.upcomingData?.results!.count ?? 0)
            }

        }else{
            return self.searchData?.results?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.tableView{
            if indexPath.row == 0{
                let cell = Bundle.main.loadNibNamed(String(describing: HomeSliderCell.self), owner: self, options: nil)?.first  as! HomeSliderCell


                cell.setData(vc: self,results: (nowplaying?.results))
                return cell
            }else{
                let cell = Bundle.main.loadNibNamed(String(describing: MovieCell.self), owner: self, options: nil)?.first  as! MovieCell
                //cell.setData(url: "https://image.tmdb.org/t/p/w500/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", title: "Marriage Story", Detail: "Noah Baumbach's incisive and compassionate look at a marriage breaking up and a family staying together.", Date: "06.08.2020")
                cell.setData(movie: (upcomingData?.results![indexPath.row-1])!)


                return cell
            }
        }else{
            let cell = Bundle.main.loadNibNamed(String(describing: MovieCell.self), owner: self, options: nil)?.first  as! MovieCell
            //cell.setData(url: "https://image.tmdb.org/t/p/w500/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg", title: "Marriage Story", Detail: "Noah Baumbach's incisive and compassionate look at a marriage breaking up and a family staying together.", Date: "06.08.2020")

            if searchData != nil{
                cell.setData(movie: (searchData?.results![indexPath.row])!)
            }



            return cell
        }




    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {


        if indexPath.row != 0 {

            if tableView == self.tableView{
                if indexPath.row == (upcomingData?.results!.count)! - 1{
                    print("Last getUpcoming -> \(upcomingData?.results![indexPath.row].original_title)")
                    //Load More
                    if self.upcomingData != nil{
                        if (self.upcomingData?.total_pages)! >= (self.upcomingData?.page)! + 1 {
                            getUpcoming()
                        }
                    }
                }
            }else if tableView == self.tableviewSearch{

                if indexPath.row == (searchData?.results!.count)! - 1{
                    print("Last getSearch -> \(searchData?.results![indexPath.row].original_title)")
                    //Load More
                    if self.searchData != nil{
                        print(self.searchData?.total_pages)
                        if (self.searchData?.total_pages)! >= (self.searchData?.page)! + 1 {
                            getSearch()
                        }
                    }
                }
            }

            var lastInitialDisplayableCell = false
            //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
            if 10 > 0 && !finishedLoadingInitialTableCells {
                if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                   let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                    lastInitialDisplayableCell = true
                }
            }

            if !finishedLoadingInitialTableCells  && finishedLoadingInitialTableCells_dataCheck{

                if lastInitialDisplayableCell {
                    finishedLoadingInitialTableCells = true
                }

                //animates the cell as it is being displayed for the first time
                cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height/2)
                cell.alpha = 0

                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
                }, completion: nil)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {



        if tableView == self.tableView{
            if indexPath.row == 0{
                return UIScreen.main.bounds.width / 1.4
            }else{
                return 120
            }
        }else{
            return 120
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        DispatchQueue.main.async {



            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController
            {
                if tableView == self.tableView{
                    vc.id = (self.upcomingData?.results![indexPath.row-1].id)!
                }else if tableView == self.tableviewSearch{
                    vc.id = (self.searchData?.results![indexPath.row].id)!
                }

                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
            
        }

    }

    ///Tableview

}

