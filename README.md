# Hanenoba - コミュニティ・ポータル

Hanenobaは、共有スペースでのコミュニティ活動を活性化させるための、イベント管理・予約システムです。
利用者は手軽にイベントを探して予約でき、管理者は集客状況をリアルタイムで把握・管理できます。

## 🚀 主要な技術スタック

- **Backend**: Ruby 4.x / Rails 8.x
- **Frontend**: Tailwind CSS / ViewComponent
- **認証**: 
  - 管理者: Devise (Email/Password)
  - 一般ユーザー: LINEログイン (OmniAuth) ※管理者による承認制
- **環境構築**: Docker Compose (MySQLベース)

## 🏗️ 設計思想とアーキテクチャ

このプロジェクトでは、メンテナンス性と可読性を高めるために以下の設計パターンを採用しています。

### 1. Fat Model, Skinny Controller
ビジネスロジック（計算、状態判定、バリデーション）はできるだけ **Model** (`app/models`) に集約しています。

### 2. Service Object パターン
複数のモデルを操作したり、外部APIと連携したりするような「複雑な一連の処理」は、コントローラーではなく **Service Object** (`app/services`) に切り出しています。
- **`BookingService`**: 排他制御（ロック）を伴う精緻な申し込みロジックを担当。
- **`BulkBookingService`**: 複数イベントへの一括申し込みを安全に実行。

### 3. I18n (多言語対応) の分割管理
文言の修正を容易にし、コードの見通しを良くするため、テキストは `config/locales/` 配下で機能ごとに分割管理されています。
- `views.ja.yml`: 一般的な表示文言
- `devise.ja.yml`: 認証関係（LINEログイン含む）の文言
- `models.ja.yml`: モデルのカラム名など

## 📁 主要なディレクトリ構造

```text
app/
├── controllers/          # コントローラー
│   ├── admin/            # 管理者画面用
│   ├── users/            # 一般ユーザー認証用 (LINEログイン専用)
│   └── bookings_controller.rb # 予約処理
├── models/               # モデル (DB連携、ビジネスロジック)
│   ├── event.rb          # イベントのロジック
│   ├── user.rb           # 利用者データ (LINE SSO)
│   └── admin.rb          # 管理者データ
├── services/             # サービスオブジェクト (複雑なトランザクション)
├── views/                # ビュー
│   ├── admin/            # 管理者画面テンプレート
│   ├── users/            # 一般ユーザー用ログイン画面
│   └── events/           # 一般ユーザー用イベント一覧
└── components/           # ViewComponent (再利用可能なUI部品)
```

## 🛠️ 開発の始め方

### 1. サービスの起動
Docker Compose を使用して、アプリケーションとDBを起動します。

```bash
docker compose up -d
```

### 2. Rails 開発サーバーの起動
CSSのビルドと合わせてサーバーを起動します。

```bash
bin/dev
```

### 3. 初期データの投入
```bash
bin/rails db:seed
```

---

*Built with precision and style. Enjoy the development of Hanenoba!*
