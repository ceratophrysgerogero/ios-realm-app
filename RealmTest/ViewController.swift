//
//  ViewController.swift
//  RealmTest
//
//  Created by 岩崎瑛佑 on 2020/08/19.
//  Copyright © 2020 岩崎瑛佑. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController , UITextFieldDelegate {
    //テキストフィールドとテーブルビューを紐付け
      @IBOutlet weak var textFiled: UITextField!
      @IBOutlet weak var table: UITableView!

      // ②・・・作成したTodoModel型の変数を用意。<TodoModel>という書き方はいわゆるジェネリック
      //Realmから受け取るデータを突っ込む変数を準備
      var itemList: Results<TodoModel>!

      override func viewDidLoad() {
        super.viewDidLoad()

        // ③・・・Realmをインスタンス化
        // Realmのインスタンスを取得
        let realm = try! Realm()

        // ④・・・Realmのfunctionでデータを取得。functionを更に追加することで、フィルターもかけられる
        // Realmデータベースに登録されているデータを全て取得
        // try!はエラーが発生しなかった場合は通常の値が返されるが、エラーの場合はクラッシュ
        self.itemList = realm.objects(TodoModel.self)
      }


      // 追加ボタンを押したら発動
      @IBAction func addButton(_ sender: Any) {

        // モデルクラスをインスタンス化
        let todoModel:TodoModel = TodoModel()

        // テキストフィールドの名前を突っ込む
        todoModel.text = self.textFiled.text

        // Realmデータベースを取得
        // try!はエラーが発生しなかった場合は通常の値が返されるが、エラーの場合はクラッシュ
        let realm2 = try! Realm()

        // ⑤・・・Realmインスタンスからaddを叩くと、データベースにレコードが追加される
        // テキストフィールドの情報をデータベースに追加
        try! realm2.write {
          realm2.add(todoModel)
        }

        // テーブルリストを再読み込み
        self.table.reloadData()
      }


    }


    extension ViewController: UITableViewDataSource {

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // TodoModelクラス型の変数を宣言
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // 取得したTodoリストからn番目を変数に代入
        let item: TodoModel = self.itemList[(indexPath as NSIndexPath).row];

        // 取得した情報をセルに反映
        cell.textLabel?.text = item.text
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        return cell
      }
}

