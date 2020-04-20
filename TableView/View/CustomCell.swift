
import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - Propeties
    
    let userInfoContainerView: UIView = {
         let containerView = UIView()
          containerView.translatesAutoresizingMaskIntoConstraints = false
          return containerView
      }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatar: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.setRadius(radius: 14)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    

    //MARK: - Cell Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addViewToSubview()
        addConstraints()
       
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Constraints and Add Subview Functions
    fileprivate func addConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: userInfoContainerView.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalTo: userInfoContainerView.heightAnchor, multiplier: 0.5),
            avatar.leadingAnchor.constraint(equalTo: userInfoContainerView.leadingAnchor, constant: 5)
            ])
    }
    
    fileprivate func addViewToSubview() {
        [titleLabel, descriptionLabel, avatar].forEach{userInfoContainerView.addSubview($0)}
    }
    
    
}
