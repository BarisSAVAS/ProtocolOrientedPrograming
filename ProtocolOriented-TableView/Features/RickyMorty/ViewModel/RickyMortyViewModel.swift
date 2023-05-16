//
//  RickyMortyViewModel.swift
//  ProtocolOriented-TableView
//
//  Created by Barış Savaş on 12.05.2023.
//

import Foundation

protocol IRickyMortyViewModel {
    func fetchItems()
    func changeLoading()
    var rickyMortyCharacters:[Result]{get set}
    var rickyMortyService:RickyMortyService {get}
    var rickyMortyOutput:RickyMortyOutput? {get}
    func setDelegate(output: RickyMortyOutput)
}
final class RickyMortyViewModel:IRickyMortyViewModel {
    var rickyMortyOutput: RickyMortyOutput?
    
    func setDelegate(output: RickyMortyOutput) {
        rickyMortyOutput = output
    }
    
    var rickyMortyCharacters: [Result] = []
    private var isLoading = false;
    var rickyMortyService: RickyMortyService
     
    init(){
        rickyMortyService = RickyMortyService()
    }
    func fetchItems() {
        rickyMortyService.fetcAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickyMortyCharacters = response ?? []
            self?.rickyMortyOutput?.saveDatas(values: self?.rickyMortyCharacters ?? [])
        }
    }
    func changeLoading() {
        isLoading = !isLoading
        rickyMortyOutput?.changeLoading(isLoad: isLoading)
    }
}
