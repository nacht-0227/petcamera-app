■　各ステージの詳細手順
① feature → main（開発 → レビュー）
1. git checkout -b feature/xxx 新規ブランチ作成 (xxxは便宜変更)
2. git pull origin main リモートブランチから最新の構成情報を取得
3. feature/xxx で変更を加える
4. git push origin feature/xxx　リモートブランチに変更をpush
5. GitHubでorigin/feature/xxxにマージ
6. GitHubで main に向けた PR を作成
7. PR承認

② main → staging（レビュー済み → 検証環境）
1. Githudでmain → staging PR を作成
2. PR承認
3. Terraform Apply (staging) が発火
4. infra/stg に対して terraform apply が実行される
5. S3に stg/terraform.tfstate が保存され、DynamoDBロックも有効

③ staging → production（検証済み → 本番昇格）
1. Githudでstaging → production PR を作成
2. PR承認
3. Terraform Apply (production) が発火
4. infra/prod に対して terraform apply が実行される
5. S3に prod/terraform.tfstate が保存され、DynamoDBロックも有効
　 environment: production によって GitHub の承認制も利用可能


■　Git管理対象外ファイルについて　(.gitignore)
このプロジェクトでは、TerraformやAWS関連の一部ファイルを Git管理対象外 としています。
理由は以下の通りです：

.terraform/
Providerバイナリなどが含まれ、サイズが大きく、再現性に不要

*.tfstate
実行状態ファイル。機密情報を含む可能性があり、競合の原因にもなる

*.tfstate.backup
ステージング環境の状態ファイル。ローカル管理のみ

