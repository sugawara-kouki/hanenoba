---
name: view-components
description: 再利用可能なUIパーツは、通常のRails PartialではなくViewComponentを使用します。
trigger: auto
paths:
  - "app/views/**/*"
  - "app/components/**/*"
priority: 100
---

# UIコンポーネントの ViewComponent 化

## 概要
Hanenobaでは、フロントエンドUIの再利用性と保守性を高めるため、共通のUI部品は Rails の Partial (`_partial.html.erb`) ではなく **ViewComponent** として実装します。

## 適用ルール
1. **ViewComponent 化の対象基準**:
   * 複数の画面で再利用されるUI要素（例: ボタン、イベントカード、ステータスラベル、カレンダーなど）。
   * 単なるHTMLの破片ではなく、状態に応じた表示変更ロジック（Rubyのコード）を持つコンポーネント。

2. **ディレクトリ構成**:
   * クラス: `app/components/component_name.rb`
   * テンプレート: `app/components/component_name.html.erb`
   * テスト: `test/components/component_name_test.rb`

3. **設計上の原則**:
   * コンポーネントは独立して動作できるようにし、グローバルなインスタンス変数（`@event` など）に直接依存せず、イニシャライザ経由で明示的にオブジェクトを受け取るようにしてください。
   * Tailwind CSS を用いて美しくかつレスポンシブなスタイリングを行ってください。
