Git管理対象外ファイルについて　(.gitignore) このプロジェクトでは、TerraformやAWS関連の一部ファイルを Git管理対象外 としています。
理由は以下の通りです：

.terraform/ Provider
バイナリなどが含まれ、サイズが大きく、再現性に不要

*.tfstate 
実行状態ファイル。機密情報を含む可能性があり、競合の原因にもなる

*.tfstate.backup 
環境の状態ファイル。ローカル管理のみ

infra/stg/terraform.tfstate
Git管理対象外として明示的に除外

.terraform.lock.hcl
Providerのバージョン固定に使用。再現性確保のため Git管理対象
