# Firestore セキュリティ更新（検証待ち）

https://firebase.google.com/support/guides/compromised-emudhra-intermediate-ca

このアプリはSwift製。FirebaseFirestoreをCocoaPods修正版12.19.3へ固定。Analyticsは12.19.3が未公開のため12.19.0へ固定し、umbrella podの世代競合を避けdirect podを使用する。FirebaseFirestoreSwiftはFirestore本体へ統合済みのためimportを変更。Xcodeの既存最低OS17.0にPodfileを合わせる。

## マージ前必須
作成環境にはXcode/CocoaPodsがなくビルド未実施。現行Podfile.lockはPodfileと不整合でFirestore自体が記録されていない。配信済みアプリのSDKバージョンはこのロックから判断できない。

Macで `pod update --repo-update` を実行してPodfile.lockを再生成しPRへコミットする。FirebaseFirestoreとFirebaseFirestoreInternalが12.19.3か確認。`xcodebuild -list -workspace TravelPlanner.xcworkspace`でschemeを確認して、署名なしReleaseビルド、署名付きArchiveを実施する。

旧版から上書き更新し、旅行計画の履歴・保存・共有・通報、Firestore Codable/DocumentIDの復元、通知・広告・認証をテスト用アカウントで確認する。コレクション名・文書ID・保存形式・Security Rulesは変更していない。SDK世代変更のため実機互換性は未保証。

App Store Connectの配信バージョンとArchive/コミットを照合し、新しいビルド番号でTestFlight検証後、セキュリティ更新として提出・公開し利用者へ更新案内する。古いアプリはOS/サーバー更新だけでは直らない。
