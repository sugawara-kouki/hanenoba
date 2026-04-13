# ハネノバ (Hanenoba) - コミュニティ・ポータル

「ハネノバ」は、共有スペースでのコミュニティ活動を活性化させるための、イベント管理・予約システムです。
利用者は手軽にイベントを探して予約でき、管理者は集客状況をリアルタイムで把握・管理できます。

## 🚀 主要な技術スタック

- **Backend**: Ruby on Rails (最新版)
- **Frontend**: Tailwind CSS (UI), Vanilla JS (一部機能)
- **認証**: 
  - 管理者: Devise (Email/Password)
  - 一般ユーザー: LINEログイン (SSO)
- **環境構築**: Docker Compose (MySQLベース)

## 🏗️ 設計思想とアーキテクチャ

このプロジェクトでは、メンテナンス性と可読性を高めるために以下の設計パターンを採用しています。

### 1. Fat Model, Skinny Controller
ビジネスロジック（計算、状態判定、バリデーション）はできるだけ **Model** (`app/models`) に集約しています。
- 例: 定員の充足率計算や、満員判定などは `Event` モデルが自身のメソッドとして持っています。

### 2. Service Object パターン
複数のモデルを操作したり、外部APIと連携したりするような「複雑な一連の処理」は、コントローラーではなく **Service Object** (`app/services`) に切り出しています。
- **`BookingService`**: 排他制御（ロック）を伴う精緻な申し込みロジックを担当。
- **`BulkBookingService`**: 複数イベントへの一括申し込みを安全に実行。

### 3. I18n (多言語対応) への一元化
文言の修正を容易にし、コードの見通しを良くするため、ほぼ全ての日本語テキストは `config/locales/ja.yml` で管理されています。

## 📁 主要なディレクトリ構造

Railsの標準的なディレクトリ構成に加え、保守性を高めるための構成を採用しています。

```text
app/
├── controllers/          # コントローラー (C: ルーティング、画面遷移とリクエスト処理)
│   ├── admin/            # 管理者画面用のコントローラー (Admins, Events, Usersなど)
│   ├── concerns/         # コントローラー間で共有する共通ロジック (AdminSortableなど)
│   └── bookings_controller.rb # 一般ユーザー向け (Skinnyな実装)
├── models/               # モデル (M: DB連携、純粋なビジネスロジック、バリデーション)
│   ├── event.rb          # イベントのロジック (定員判定、ステータス管理など)
│   ├── user.rb           # 利用者データ管理
│   ├── booking.rb        # 予約データ管理
│   └── admin.rb          # 管理者データ管理
├── services/             # サービスオブジェクト (複雑なトランザクションや機能の隔離)
│   ├── booking_service.rb     # 排他制御や単発予約の実行処理
│   └── bulk_booking_service.rb # 一括予約処理やエラー集計処理
├── views/                # ビュー (V: 画面の描画)
│   ├── admin/            # 管理者画面用のテンプレート (Tailwind CSSベースのプレミアムデザイン)
│   ├── devise/           # 認証系画面 (ログイン、パスワードリセットなど。i18n対応済み)
│   └── events/           # 一般ユーザー向け画面
└── helpers/              # ビューで使う共通メソッド・モジュール
    ├── application_helper.rb  # ソートリンクなどのUIヘルパー
    └── icon_helper.rb    # SVGアイコンの管理クラス

config/
└── locales/
    └── ja.yml            # アプリ内のUIテキスト・エラーメッセージの集約
```

### 💡 MVC + Service Object の流れ（今回のリファクタリング）
「コントローラーの肥大化（Fat Controller）」を防ぐため、役割を明確に分割しています。

1. **Controller**: ユーザーからのパラメーターを受け取り、**Service** に処理を委譲。結果に応じて Flash メッセージをセットし、**View** へ画面遷移（リダイレクト・レンダリング）する役割だけに専念します。
2. **Service**: Controller から呼ばれ、排他制御（DBロック）や複雑な条件分岐を行い、**Model** を駆使してデータの保存や更新を行います。結果（成功か失敗か、表示すべきメッセージは何か）を Controller に返却します。
3. **Model**: 外部に依存しない、データそのものが持つルール（バリデーションや「定員オーバーか？」の判定など）を自己完結で担当します。


## 🛠️ 開発の始め方

### 1. サービスの起動
Docker Compose を使用して、アプリケーションとDBを起動します。

```bash
docker compose up -d
# ログを確認する場合
docker compose logs -f
```

### 2. Rails 開発サーバーの起動 (CSS/JSビルド含む)
ローカルで開発を行う際は、以下のコマンドでビルドとサーバー起動を並行して行います。

```bash
bin/dev
```

### 3. 初期データの投入
シードファイルを使用して、管理画面からすぐに確認できるダミーデータを投入できます。

```bash
bin/rails db:seed
```

---

*Built with precision and style. Enjoy the development of Hanenoba!*
