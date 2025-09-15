■　各ステージの詳細手順
① feature → main（開発 → レビュー）
1. feature/xxx で変更を加える
2. git push origin feature/xxx
3. GitHubで main に向けた PR を作成
4. PR作成時に Terraform Plan (staging) が発火
- terraform plan 結果が PR コメントに投稿される
- 差分をレビューしやすくなる

② main → staging（レビュー済み → 検証環境）
1. PRを main にマージ
2. git push origin main:staging で staging に昇格
3. Terraform Apply (staging) が発火
- infra/stg に対して terraform apply が実行される
- S3に stg/terraform.tfstate が保存され、DynamoDBロックも有効

③ staging → production（検証済み → 本番昇格）
1. staging の内容を main にマージ（再確認）
2. git push origin main:production で本番昇格
3. Terraform Apply (production) が発火
- infra/prod に対して terraform apply が実行される
- S3に prod/terraform.tfstate が保存され、DynamoDBロックも有効
- environment: production によって GitHub の承認制も利用可能


■　Git管理対象外ファイルについて　(.gitignore)
このプロジェクトでは、TerraformやAWS関連の一部ファイルを Git管理対象外 としています。
理由は以下の通りです：

.terraform/
Providerバイナリなどが含まれ、サイズが大きく、再現性に不要

*.tfstate
実行状態ファイル。機密情報を含む可能性があり、競合の原因にもなる

*.tfstate.backup
ステージング環境の状態ファイル。ローカル管理のみ

