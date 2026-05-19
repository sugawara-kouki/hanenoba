---
name: generate-view-component
description: 新しいViewComponent（UI部品）を作成・構築します。UIコンポーネントの新規追加やスタイル調整が必要な際に使用します。
version: 1.0.0
---

# ViewComponent 生成・構築スキル

## 概要
Hanenobaプロジェクトにおいて、再利用可能なUIコンポーネント（ViewComponent）を新規作成し、Tailwind CSSでのスタイリングやプレビューの設定を行います。

## 手順
1. **コンポーネントの生成**
   `bin/rails generate component ComponentName [options]` コマンドを実行して、コンポーネントのクラスとテンプレート、テストファイルを生成します。
   * 例: `bin/rails generate component EventCard event`
   
2. **実装**
   * `app/components/component_name.rb` に必要なプロパティ、初期化メソッド（`initialize`）を定義します。
   * `app/components/component_name.html.erb` にマークアップを書き、Tailwind CSSを用いてスタイリングを行います。

3. **プレビューの設定 (任意)**
   * `test/components/previews/` 配下にプレビュークラスを作成し、ブラウザからコンポーネントの見た目を確認できるようにします。
     * 例: `test/components/previews/event_card_preview.rb`

4. **テストの記述**
   * 生成された `test/components/component_name_test.rb` にコンポーネントのレンダリング結果の検証テストを記述します。
   * `bundle exec rspec` または `rails test` を実行して、追加したコンポーネントのテストがパスすることを確認します。
