//
//  MovieDetailMoreLikeThisCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieDetailMoreLikeThisCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {




    @IBOutlet weak var collectionView: UICollectionView!


    var vc:UIViewController? = nil

    var id:Int = 0

    var similarData:DataResults? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        var collectionViewLayout: UICollectionViewLayout = {

            let layout = UICollectionViewCompositionalLayout { [self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
                return self.layoutSection()
            }


            return layout
        }()

        collectionView!.collectionViewLayout = collectionViewLayout

        collectionView.register(UINib(nibName: String(describing: MovieDetailMoreLikeThisCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieDetailMoreLikeThisCollectionCell.self))
        DispatchQueue.main.async {
            //self.collectionView.reloadData()
            self.getSimilar()
        }



    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(vc:UIViewController,id:Int) {
        self.vc = vc
        self.id = id
    }


    ///API

    func getSimilar() {
        APIClient.getSimilar(id: id) { (success, error, data) in
            self.similarData = data
            self.collectionView.reloadData()
        }
    }

    ///API



    ///CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarData?.results?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieDetailMoreLikeThisCollectionCell.self), for: indexPath) as! MovieDetailMoreLikeThisCollectionCell

        //cell.setData(url: "https://image.tmdb.org/t/p/w500/stmYfCUGd8Iy6kAMBr6AmWqx8Bq.jpg",name: "Deneme",year: "(2019)")
        cell.setData(movie: (self.similarData?.results![indexPath.row])!)

        return cell
    }


    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {



            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController
            {
                vc.id = (self.similarData?.results![indexPath.row].id)!

                vc.modalPresentationStyle = .overCurrentContext
                self.vc.self!.present(vc, animated: true, completion: nil)
            }

        }
    }

    //CollectionView
}
