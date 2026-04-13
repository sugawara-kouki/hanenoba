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
