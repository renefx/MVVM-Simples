//
//  DogViewModel.swift
//  MVVM Simples
//
//  Created by Wesley Brito on 12/03/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit

// Este protocolo está relativo a quem implementa a DogViewModel, que possui uma instância deste delegate para ser acionado. Assim temos um baixo aclopamento relacionado ao ViewModel, podendo haver reutilização do ViewModel em diferentes Views.
protocol DogDelegate: class {
    func updateBackgroundColor(color: UIColor)
}

class DogViewModel{
    
    var dog: Dog
    
    // O delegate da ViewModel necessita ser weak, para não haver Retain Cycle quando o objeto for removido.
    weak var delegate: DogDelegate?
    
    init(nickname: String) {
        self.dog = Dog(nickname: nickname)
    }
    
    func changeLegs() {
        // Neste trecho, somente é adicionado um valor randomico de 0 a 4 na quantidade de pernas do cachorro.
        // Como o dado é alterado na Model, logo então, é disparado um evento para ser atualizado na Label que é mostrada na tela, através do conceito de KVO.
        self.dog.legs.value = Int(arc4random_uniform(4))
    }
    
    func changeBackground() {
        // Neste caso, existe uma diferença, depois de ser escolhido um valor de cor para View, é chamado o delegate relacionado a esta ViewModel, lançando um evento para a View ser atualizada com as informações necessárias.
        // A questão é: "Por que eu não posso mudar diretamente na ViewModel, e tenho que ficar chamando um Delegate?". A resposta é simples: A ViewModel tem a responsabilidade relacionadas a regras negociais e preparação dos dados da View. A View tem a responsabilidade somente de atualizar as informações que estão sendo apresentadas na tela.
        let randomColor = BackgroundColors.chooseColor(value: Int(arc4random_uniform(4)))
        self.delegate?.updateBackgroundColor(color: randomColor)
    }
    
}

struct BackgroundColors {
    static func chooseColor(value: Int) -> UIColor {
        switch value {
        case 1: return .cyan
        case 2: return .red
        case 3: return .brown
        default: return .white
        }
    }
}
