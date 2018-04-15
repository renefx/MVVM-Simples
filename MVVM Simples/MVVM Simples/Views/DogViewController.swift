//
//  DogViewController.swift
//  MVVM Simples
//
//  Created by Augusto Reis on 16/03/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import Bond

class DogViewController: UIViewController {

    @IBOutlet weak var textFieldNickname: UITextField!
    @IBOutlet weak var labelNickname: UILabel!
    @IBOutlet weak var labelNumberLegs: UILabel!
    @IBOutlet weak var buttonChangeLegs: UIButton!
    @IBOutlet weak var buttonChangeBackground: UIButton!
    
    var viewModel: DogViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialização da ViewModel a View.
        // Não existe a necessidade do init passar dados, mas é recomendado para realização de injeção de dependência quando for realizado testes Unitários e UI
        self.viewModel = DogViewModel(nickname: "Luke")
        
        // Existe a necessidade de delegar as ações da viewModel a esta classe, para que os dados possam ser atualizados, e as ações sejam respondidas por esta classe.
        self.viewModel?.delegate = self
        
        // Realização dos binds dos objetos da view para um model.
        self.addBindings()
    }
    
    func addBindings() {
        // É feito o bind bidirecional quando é utilizado um TextField, pois quando o valor é alterado no Model, ele é automaticamente refletido no TextField, como exemplo: máscaras, valores com R$, entre outros. Igualmente quando o valor é alterado no TextField pelo usuário quando digita pelo teclado, o valor é alterado diretamente no Model.
        self.viewModel?.dog.nickname.bidirectionalBind(to: textFieldNickname.reactive.text)
        
        // Quando o valor é do tipo String, é feito um bind da Model para View, sendo unidirecional. Quando o dado na Model é alterado, já é refletido na Label.
        self.viewModel?.dog.nickname.bind(to: labelNickname.reactive.text)
        
        // Quando o valor é diferente do tipo String, é necessário fazer um .map da propriedade, pois a label da view só aceita o tipo String.
        // É feito um map, para com um ternário para valores padrões, depois realizado o bind a propriedade.
        self.viewModel?.dog.legs.map{"\($0 ?? 0 )"}.bind(to: labelNumberLegs.reactive.text)
        
        // Os botões possuem um bind diferente, é necessário informar o método que a ViewModel será chamado. A regra de ouro é.. "Não delegue à View as coisas que pertencem a ViewModel"
        // Neste caso, é realizado o bind do evento de `tap`. Não é feito o link da ação direta do Storyboard para esta classe, somente a referência do botão para que seja realizado o bind manualmente.
        // A ação de observeNext é disparada após que ocorra uma ação.
        // Foi colocado o `let _` porque o Xcode reclama de variavel não utilizada.
        let _ = self.buttonChangeLegs.reactive.tap.observeNext { _ in
            self.viewModel?.changeLegs()
        }
        
        let _ =  self.buttonChangeBackground.reactive.tap.observeNext { _ in
            self.viewModel?.changeBackground()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DogViewController:  DogDelegate {
    
    // Esse método é obrigatório para a View, que relaciona os eventos chamados pela ViewModel através do protocolo assinado.
    func updateBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
    }
}
