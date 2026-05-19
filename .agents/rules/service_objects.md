---
name: service-objects
description: 複雑なビジネスロジックやトランザクション、外部API連携はService Objectに記述します。
trigger: auto
paths:
  - "app/controllers/**/*"
  - "app/models/**/*"
  - "app/services/**/*"
priority: 100
---

# Service Object パターンの徹底

## 概要
Hanenobaでは、ControllerやModelの肥大化を防ぎ、責務を明確にするために **Service Objectパターン** を採用しています。

## 適用ルール
1. **Controllerの役割**:
   * リクエストの受け取り、パラメータの許可（Strong Parameters）、セッション管理、ビューのレンダリング（またはリダイレクト）のみを担当させます。
   * ビジネスロジックを直接Controllerに書いてはいけません。

2. **Modelの役割**:
   * 単一モデルに対するバリデーション、データ状態の判定（例: `event.full?`）、シンプルなクエリロジック（Scope）のみを担当させます。

3. **Service Objectの作成基準**:
   * 複数のモデルにまたがる作成・更新・削除処理。
   * トランザクションやロック制御を伴う処理（例: 予約の確定処理）。
   * 外部API（LINE Messaging APIやLINE Loginなど）との通信処理。

4. **記述方法**:
   * `app/services/` 配下に配置します。
   * 原則として `call` メソッドのみをパブリックにし、処理を実行できるようにします。
   * 例: `BookingService.new(user, event).call`
