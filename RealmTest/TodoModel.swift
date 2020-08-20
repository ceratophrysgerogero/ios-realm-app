//
//  TodoModel.swift
//  RealmTest
//
//  Created by 岩崎瑛佑 on 2020/08/19.
//  Copyright © 2020 岩崎瑛佑. All rights reserved.
//

import Foundation
import RealmSwift

class TodoModel: Object{
  @objc dynamic var text: String? = nil
}
