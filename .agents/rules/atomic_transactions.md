---
name: atomic-transactions
description: 在庫数や予約上限の更新・チェックはアトミックなトランザクションと排他制御を徹底します。
trigger: auto
paths:
  - "app/services/**/*"
  - "app/models/**/*"
priority: 100
---

# アトミックな在庫/定員管理（トランザクション制御）の原則

## 概要
「残り1枠」に対する同時申し込み時の定員オーバーを防ぐため、データベースのトランザクションおよび排他制御（ロック）を適切に設計します。

## 適用ルール
1. **トランザクションの適用**:
   * 在庫数や予約数を判定し、データを更新する一連の処理は必ず `ActiveRecord::Base.transaction` で囲んで実行してください。

2. **排他制御（ロック）の実施**:
   * 空き枠のチェック（例: `event.full?`）を行う前に、対象のイベントレコード（または関連レコード）に対して必ず悲観的ロック（`lock!` または `lock` メソッド）を適用し、他スレッドからの割り込みを防いでください。
   * 例:
     ```ruby
     ActiveRecord::Base.transaction do
       event.lock! # 対象のイベントレコードをロック
       if event.bookings.count < event.capacity
         # 予約作成処理
       else
         raise StandardError, "定員に達しました"
       end
     end
     ```

3. **アトミック性の担保**:
   * メモリ上でのチェックだけで済ませず、必ずデータベース上の排他ロック状態を確立した上でバリデーションと書き込みを行うロジックを設計してください。
