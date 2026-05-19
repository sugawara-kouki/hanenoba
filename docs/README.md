# Hanenoba 設計ドキュメント

本ディレクトリでは、Hanenobaプロジェクトにおける要件・仕様・設計ドキュメントを管理しています。

## 設計ドキュメント体系

### 1. 全体仕様
*   [システム仕様書](system_spec.md): システム全体の概要、開発スタック、全体データモデル（ER図）、ロードマップなど、プロジェクト全体の俯瞰図。
*   [機能一覧・ドキュメント作成状況管理表](features_list.md): 実装済みの全機能のリストと、各種設計ドキュメントの作成状況マトリクス。

### 2. 基本設計（外部設計）
ユーザーや外部システムから見える「What（何を成し遂げるか）」の仕様です。

*   **全体仕様**:
    *   [画面遷移・UI設計](basic_designs/ui_and_transitions.md) （※未作成）
    *   [LINE API連携仕様書](basic_designs/line_api_integration.md) （※未作成）
*   **機能別基本設計 (`docs/basic_designs/features/`)**:
    *   [予約処理 基本設計書](basic_designs/features/booking.md)
    *   [予約キャンセル処理（管理者） 基本設計書](basic_designs/features/cancellation.md)
    *   [LINEログイン認証 基本設計書](basic_designs/features/line_login.md)
    *   [イベント一覧表示 基本設計書](basic_designs/features/event_index.md)
    *   [イベント詳細表示 基本設計書](basic_designs/features/event_show.md)
    *   [複数イベント一括予約 基本設計書](basic_designs/features/bulk_booking.md)
    *   [予約カレンダーマイページ 基本設計書](basic_designs/features/mypage_calendar.md)
    *   [管理ダッシュボード 基本設計書](basic_designs/features/admin_dashboard.md)
    *   [イベント管理 (CRUD) 基本設計書](basic_designs/features/admin_events.md)
    *   [イベントタイプ管理 (CRUD) 基本設計書](basic_designs/features/admin_event_types.md)
    *   [会員管理 (CRUD) 基本設計書](basic_designs/features/admin_users.md)
    *   [管理者アカウント管理 (CRUD) 基本設計書](basic_designs/features/admin_admins.md)

### 3. 詳細設計（内部設計）
開発者がコードを実装し、テストを記述するための「How（どう実装するか）」の設計です。

*   **全体仕様**:
    *   [データベース物理設計書](detailed_designs/db_physical_schema.md) （※未作成）
*   **機能別詳細設計 (`docs/detailed_designs/features/`)**:
    *   [予約処理 詳細設計書](detailed_designs/features/booking.md)
    *   [予約キャンセル処理（管理者） 詳細設計書](detailed_designs/features/cancellation.md)
    *   [LINEログイン認証 詳細設計書](detailed_designs/features/line_login.md)
    *   [イベント一覧表示 詳細設計書](detailed_designs/features/event_index.md)
    *   [イベント詳細表示 詳細設計書](detailed_designs/features/event_show.md)
    *   [複数イベント一括予約 詳細設計書](detailed_designs/features/bulk_booking.md)
    *   [予約カレンダーマイページ 詳細設計書](detailed_designs/features/mypage_calendar.md)
    *   [管理ダッシュボード 詳細設計書](detailed_designs/features/admin_dashboard.md)
    *   [イベント管理 (CRUD) 詳細設計書](detailed_designs/features/admin_events.md)
    *   [イベントタイプ管理 (CRUD) 詳細設計書](detailed_designs/features/admin_event_types.md)
    *   [会員管理 (CRUD) 詳細設計書](detailed_designs/features/admin_users.md)
    *   [管理者アカウント管理 (CRUD) 詳細設計書](detailed_designs/features/admin_admins.md)

### 4. テスト仕様書
品質を保証するために検証すべきテスト観点・シナリオの定義です。

*   **全体仕様**:
    *   [テスト記述ガイドライン](test_specs/guideline.md) （※未作成）
*   **機能別テストシナリオ (`docs/test_specs/scenarios/`)**:
    *   [予約処理 テストシナリオ](test_specs/scenarios/booking.md)
    *   [予約キャンセル処理（管理者） テストシナリオ](test_specs/scenarios/cancellation.md)
    *   [LINEログイン認証 テストシナリオ](test_specs/scenarios/line_login.md)
    *   [イベント一覧表示 テストシナリオ](test_specs/scenarios/event_index.md)
    *   [イベント詳細表示 テストシナリオ](test_specs/scenarios/event_show.md)
    *   [複数イベント一括予約 テストシナリオ](test_specs/scenarios/bulk_booking.md)
    *   [予約カレンダーマイページ テストシナリオ](test_specs/scenarios/mypage_calendar.md)
    *   [管理ダッシュボード テストシナリオ](test_specs/scenarios/admin_dashboard.md)
    *   [イベント管理 (CRUD) テストシナリオ](test_specs/scenarios/admin_events.md)
    *   [イベントタイプ管理 (CRUD) テストシナリオ](test_specs/scenarios/admin_event_types.md)
    *   [会員管理 (CRUD) テストシナリオ](test_specs/scenarios/admin_users.md)
    *   [管理者アカウント管理 (CRUD) テストシナリオ](test_specs/scenarios/admin_admins.md)

---

## ドキュメント作成・更新のルール
設計書を追加・更新する際は、`.agents/rules/documentation.md` に定められている「ドキュメント作成のガイドライン」を必ず遵守してください。

*   **配置ディレクトリの厳守**: カテゴリごとに適切なディレクトリに配置します。
*   **1機能1ファイル**: 階層が深くならないよう、機能単位（`booking` など）で1つのファイルに情報をまとめます。## 設計とテストの対応関係
Hanenobaでは、設計書とテスト仕様がV字モデルのように一対一で対応するよう整理しています。

1. **基本設計（外部設計） ⇄ 結合テスト（シナリオテスト）**
   * [基本設計](basic_designs/features/booking.md)で定義した業務フローやAPIの組み合わせ挙動は、[テストシナリオ](test_specs/scenarios/booking.md)による結合テストレベルで検証します。
2. **詳細設計（内部設計） ⇄ 単体テスト**
   * [詳細設計]で定義した Service Object の内部ロジックやデータベースの制約などは、RSpecによるユニットテストで個別に検証します。

*   **基本・詳細・テストの分離**: 外部仕様（What）、内部構造（How）、検証観点（Test）をファイルレベルで分け、ドキュメントの肥大化を防ぎます。

