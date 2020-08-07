//
//  MovieDetailViewController.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {




    @IBOutlet weak var tableView: UITableView!

    var id:Int = 0

    var data:Details? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never

        getDetail()
        self.setNeedsStatusBarAppearanceUpdate()


        swipeCongtrol()

        self.navigationController?.navigationBar.barStyle = .black

    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .darkContent
        setNeedsStatusBarAppearanceUpdate()
    }


    ///API

    func getDetail() {
        APIClient.getDetail(id: id) { (success, error, data) in
            DispatchQueue.main.async {

                print(data)
                self.data = data
                self.tableView.reloadData()
                self.tableView.layoutIfNeeded()

            }
        }
    }

    ///API



    func swipeCongtrol(){

    var swipeLeft:UISwipeGestureRecognizer!

    swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))

    swipeLeft.direction  = .left
    swipeLeft.view?.tag = 101
    swipeLeft.view?.tag = 5
    self.view.addGestureRecognizer(swipeLeft!)

    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)






}

    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {








        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            print("Swipe Right")



            let startLocation = gesture.location(in: self.view)




            if(startLocation.x <= 100 ){

                print(gesture.location(in: self.view))
                self.dismiss(animated: true, completion: nil)

            }else{
            }





        }

    }



    ///Tableview

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data == nil{
            return 0
        }else{
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{

            let cell = Bundle.main.loadNibNamed(String(describing: MovieDetailBigImage.self), owner: self, options: nil)?.first  as! MovieDetailBigImage
            //cell.setData(vc: self,url: "https://image.tmdb.org/t/p/w500/stmYfCUGd8Iy6kAMBr6AmWqx8Bq.jpg")
            cell.setData(vc: self, url: "\(Constants.Api.imageUrl)\(data?.poster_path ?? "")")
            return cell

        }else if indexPath.row == 1{

            let cell = Bundle.main.loadNibNamed(String(describing: MovieDetailContentCell.self), owner: self, options: nil)?.first  as! MovieDetailContentCell

            cell.setData(movie: self.data!)
            return cell

        }else if indexPath.row == 2{

            let cell = Bundle.main.loadNibNamed(String(describing: MovieDetailMoreLikeThisCell.self), owner: self, options: nil)?.first  as! MovieDetailMoreLikeThisCell
            cell.setData(vc: self, id: self.id)
            return cell

        }else{

            let cell = Bundle.main.loadNibNamed(String(describing: MovieDetailBigImage.self), owner: self, options: nil)?.first  as! MovieDetailBigImage
            return cell

        }



    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {


        if indexPath.row == 0{
            return 275
        }else  if indexPath.row == 1{
            return UITableView.automaticDimension
        }else  if indexPath.row == 2{
            return 500
        }else{
            return UITableView.automaticDimension
        }
    }

    ///Tableview

    




}
