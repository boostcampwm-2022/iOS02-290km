//
//  ConvertDateToStringUseCase.swift
//  Trinap
//
//  Created by kimchansoo on 2022/12/12.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

protocol ConvertDateToStringUseCase {
    func convert(startDate: Date, endDate: Date) -> String?
}
