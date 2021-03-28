//
//  ItemCollectionViewCell.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ItemCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    /* En los ejemplos que teníamos tuyos, creabas una función para asignar el texto al label y la imagen a la imageView
     En mi caso, creo una propiedad del mismo tipo que los items que va a tener la collectionView y en el momento de crear
     la celda en el datasource, le asigno a esta propiedad el valor que corresponda y con el didSet se asigna el valor al
     label y la imageView. */
    var item: CellItemContract! {
        didSet {
            nameLabel.text = item.itemName
            itemImage.sd_setImage(with: item.itemImage, placeholderImage: UIImage(named: "NotImage"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        // Cancelo la descarga de la imagen anterior cuando la celda va a ser reusada, para no seguir cargando una imagen
        // que no se va mostrar.
        super.prepareForReuse()
        itemImage.sd_cancelCurrentImageLoad()
    }

}
