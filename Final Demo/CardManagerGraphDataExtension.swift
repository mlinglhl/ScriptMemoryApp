//
//  CardManagerGraphDataExtension.swift
//  Final Demo
//
//  Created by Minhung Ling on 2017-02-27.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

extension CardManager {
    func getCategoryDataAtIndex(_ index: Int) -> [Double] {
        //generate data from setArray.categories[index]
        let data: [Double] = [12/17*100, 23/25*100, 13/16*100, 24/36*100, 13/14*100, 12/100*100]
        let data2: [Double] = [7/17*100, 21/25*100, 14/16*100, 33/36*100, 2/14*100, 88/100*100]
        let data3: [Double] = [15/17*100, 17/25*100, 8/16*100, 12/36*100, 10/14*100, 85/100*100]
        let data4: [Double] = [14/17*100, 20/25*100, 16/16*100, 35/36*100, 12/14*100, 95/100*100]
        let data5: [Double] = [10/17*100, 12/25*100, 11/16*100, 21/36*100, 5/14*100, 65/100*100]
        let data6: [Double] = [17/17*100, 22/25*100, 12/16*100, 11/36*100, 14/14*100, 95/100*100]
        let dataArray = [data, data2, data3, data4, data5, data6]
        let selector = randomNumber(6)
        return dataArray[Int(selector)]
    }
    
    func getCardDataAtIndex(_ index: Int) -> [Double] {
        //generate data from setArray.categories[categoryIndex].cards[index]
        let data: [Double] = [12/17*100, 23/25*100, 13/16*100, 24/36*100, 13/14*100, 12/100*100]
        let data2: [Double] = [7/17*100, 21/25*100, 14/16*100, 33/36*100, 2/14*100, 88/100*100]
        let data3: [Double] = [15/17*100, 17/25*100, 8/16*100, 12/36*100, 10/14*100, 85/100*100]
        let data4: [Double] = [14/17*100, 20/25*100, 16/16*100, 35/36*100, 12/14*100, 95/100*100]
        let data5: [Double] = [10/17*100, 12/25*100, 11/16*100, 21/36*100, 5/14*100, 65/100*100]
        let data6: [Double] = [17/17*100, 22/25*100, 12/16*100, 11/36*100, 14/14*100, 95/100*100]
        let dataArray = [data, data2, data3, data4, data5, data6]
        let selector = randomNumber(6)
        return dataArray[Int(selector)]
    }
    
    func getCardLabels() -> [String] {
        var nameArray = [String]()
        for card in sampleActiveArray[setIndex].categories[categoryIndex].cards {
            nameArray.append("\(card.number)")
        }
        return nameArray
    }
}
