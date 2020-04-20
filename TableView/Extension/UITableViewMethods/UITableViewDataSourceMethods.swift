
import UIKit

//MARK: - UITableView Data Source Methods

extension HomeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingDataArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! CustomCell
        cell.descriptionLabel.text = incomingDataArray[indexPath.row].rows[indexPath.row].description
        cell.titleLabel.text = incomingDataArray[indexPath.row].rows[indexPath.row].title
        //Download Image, assign it and Cache it
        let url  = URL(string: incomingDataArray[indexPath.row].rows[indexPath.row].image)
        DispatchQueue.main.async {
            ImageService.getImage(withURL: url!) { (image) in
                cell.avatar.image = image
            }
        }
    return cell
    }
}


