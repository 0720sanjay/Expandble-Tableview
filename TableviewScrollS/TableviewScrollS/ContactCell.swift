import UIKit

class ContactCell: UITableViewCell {
    
    var link: ViewController?
    
    @objc func handleFavorite(){
        link?.someMethodIWantToCall(cell: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
