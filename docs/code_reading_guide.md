# ソースコード読み解きガイド（Hanenoba編）

このプロジェクトは、Ruby on Rails 7 をベースに、**ViewComponent** や **Service Object** を組み合わせたメンテナンス性の高い構成になっています。
Reactなどのコンポーネントベースのフロントエンド開発に慣れている方が、効率的にソースを追うためのガイドです。

---

## 1. メンタルモデル：Reactとの違い

| 特徴 | React方式 | Rails方式（当プロジェクト） |
| :--- | :--- | :--- |
| **構造の追い方** | **空間的**（Tree構造を降りる） | **時間的**（リクエストの流れを追う） |
| **エントリーポイント** | `App.js` などのルートコンポーネント | `config/routes.rb` (URL定義) |
| **ロジックの場所** | Hooks, Utils | `app/services` (Service Objects) |
| **状態管理** | `useState`, `Context`, `Redux` | データベース + `app/models` |

---

## 2. 基本のフロー：リクエスト・ライフサイクル

Railsのソースを追うときは、常に**「ユーザーがブラウザでURLを叩いてから、画面が表示されるまで」**の旅を追います。

### Step 1: 案内所を通る (`config/routes.rb`)
まず、どのURLがどの「コントローラー」と「アクション（メソッド）」に紐付いているかを確認します。

*   **例**: `GET /events` は `events#index` (EventsControllerのindexメソッド) へ。
*   **例**: `POST /events/1/bookings` は `bookings#create` へ。

### Step 2: 指揮者が交通整理をする (`app/controllers/`)
コントローラー（Controller）は、データの入出力を管理する指揮者です。

*   `app/controllers/events_controller.rb` を開きます。
*   `def index` などのアクション内を見ます。
*   **注目ポイント**: `@events = ...` のように、ビューに渡す変数がここで準備されます。

### Step 3: 心臓部でロジックを実行 (`app/services/` & `app/models/`)
コントローラー自体には複雑な計算は書かず、専門のクラスに委譲します。

*   **Service Object (`app/services`)**: 予約の実行（`BookingService`）など、複数のテーブルを跨ぐ重要な処理がここにあります。一番「中身」が詰まっている場所です。
*   **Model (`app/models`)**: データベースのテーブルと1対1で対応し、「定員オーバーか？」などのデータ自身のルール（`event.rb`）が書かれています。

### Step 4: 部品を組み立てて画面を作る (`app/views/` & `app/components/`)
最後に、ユーザーに見えるHTMLを作ります。

*   **View (`app/views`)**: 全体的なHTML構造が書かれています。
*   **ViewComponent (`app/components`)**: **Reactコンポーネントに最も近い概念です。** カレンダーの1マスやイベントカードなど、再利用される小さな部品がここに隔離されています。

---

## 3. 実例：予約処理（Booking）を追ってみる

「予約ボタンを押した時の動き」をコードで追う手順です。

1.  **Routes**: `config/routes.rb` で `resources :bookings, only: [:create]` が `events` にネストされているのを発見。 → `BookingsController#create` が呼ばれると判明。
2.  **Controller**: `app/controllers/bookings_controller.rb` の `create` を見る。
    *   `BookingService.new(...).call` を呼んでいるのを発見。
3.  **Service**: `app/services/booking_service.rb` を開く。
    *   ここで `ActiveRecord::Base.transaction` を使い、定員チェックと保存を「アトミック（不可解）」に行っている「実装の中身」を理解。
4.  **Model**: `app/models/event.rb` を見る。
    *   `def full?` などの判定ロジックを確認。
5.  **View**: 処理が終わった後の Flash メッセージがどこで定義されているか、 `config/locales/ja.yml` を確認。

---

## 4. 便利なショートカット

*   **文言から探す**: 画面に見えている日本語（例：「予約を確定する」）をプロジェクト全体で `Ctrl+Shift+F` (Grep) します。多くの場合 `config/locales/ja.yml` にヒットし、そこにあるキー名（例：`events.show.apply`）で検索すると、使われている View が見つかります。
*   **エラーを見る**: `bin/dev` で起動しているターミナルのログには、実行されたSQLやレンダリングされたファイルパスがリアルタイムで流れます。これが一番の「生の情報」です。

---

*このガイドに従って、まずは `EventsController` から `EventCardComponent` への流れを追ってみてください。*
