//
//  HomeSliderCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class HomeSliderCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {




    @IBOutlet weak var collectionContentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!


    var vc:UIViewController? = nil

    var results:[Results]? = nil

    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code





        

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false




        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height


        var collectionViewLayout: UICollectionViewLayout = {

            let layout = UICollectionViewCompositionalLayout { [self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
                return self.layoutSection()
            }


            return layout
        }()



        collectionView!.collectionViewLayout = collectionViewLayout


        // collectionView.collectionViewLayout = layoutSection()




        collectionView.register(UINib(nibName: String(describing: HomeSliderCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: HomeSliderCollectionViewCell.self))

        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width


        //  collectionview.isScrollEnabled = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(vc:UIViewController,results:[Results]?) {
        self.vc = vc
        self.results = results
    }



    ///CollectionView

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if results == nil{
            pageControl.numberOfPages = 0
            return 0
        }else{
            pageControl.numberOfPages = results?.count ?? 0
            return results?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeSliderCollectionViewCell.self), for: indexPath) as! HomeSliderCollectionViewCell

        //cell.setData(url: "\(Constants.Api.imageUrl)\(results?[indexPath.row].backdrop_path ?? "")")

        cell.setData(movie:(results?[indexPath.row])!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {



            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController
            {
                vc.id = (self.results![indexPath.row].id)!
                vc.modalPresentationStyle = .overCurrentContext
                self.vc.self!.present(vc, animated: true, completion: nil)
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //it's your last cell
        //Load more data & reload your collection view

        print(indexPath.row)
        pageControl.currentPage = indexPath.row


    }

    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    ///CollectionView

    
    
}
