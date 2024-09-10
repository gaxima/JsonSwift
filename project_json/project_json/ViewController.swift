//
//  ViewController.swift
//  project_json
//
//  Created by Usuário Convidado on 09/09/24.
//

import UIKit

var comic:Comic!=nil

class ViewController: UIViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
        func loadComic(){
        let jsonUrlString = "https://xkcd.com/info.0.json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url! ){ data, response, error in guard let data = data else{return}
            
            do{
                comic = try JSONDecoder().decode(Comic.self, from: data)
                let image =  self.loadimage(urlImg: comic.img)
                DispatchQueue.main.sync {
                    self.id.text = String(comic.num)
                    self.lbltitle.text = comic.title
                    self.date.text = comic.day + "/" + comic.month + "/" + comic.year
                    self.image.image = image
                }
            }catch let jsonError{
                print("Error", jsonError)
            }
        }.resume()
    }
    
    func loadimage(urlImg: String)-> UIImage?{
        guard let url = URL(string: urlImg)
                
        else{
            print("nao foi possivel carregar a imagem")
            return nil
        }
        var image:UIImage? = nil
        
        do{
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        }catch{
            print(error.localizedDescription)
        }
        return image
    }

    @IBAction func exibir(_ sender: Any) {
        loadComic()
    }
}

