Docs: https://www.terraform.io/

# Terraform để làm gì?

- **Infrastructure as code**
- Ví dụ: Sếp của bạn yêu cầu thiết lập VPC cho cả 3 môi trường **dev**, **staging** và **production**. Thiết lập trên **AWS Console** nhiều công đoạn, công việc lặp đi lặp lại, dễ sai sót...
- ![Virtual Private Cloud](https://cloudacademy.com/wp-content/uploads/2016/02/nat-gateway.png)

# Các lệnh thường dùng:

- terraform init (Tải các module và thư viện)
- terraform fmt --recursive (Format code)
- terraform plan
- terraform apply

# Các tính năng chính nên quan tâm (Từ docs)

- Các lệnh CLI (https://www.terraform.io/cli/commands)
- Cú pháp tạo các resources (https://www.terraform.io/language/resources/syntax)
- Biến và data (https://www.terraform.io/language/data-sources https://www.terraform.io/language/values/variables)
- Module (https://www.terraform.io/language/modules/syntax)
- ...

# Kinh nghiệm

- Terraform cần rất nhiều quyền.
- Mặc định Terraform sẽ tạo ra file trạng thái resources khi thực thi ở local. Chúng ta nên sử dụng S3 để lưu trạng thái để có thể quản lý phiên bản và chia sẻ với nhiều người trong team.
- Nên tổ chức dưới dạng modules để dễ quản lý. Nhóm các resources lại với nhau.
- Hạn chế việc chỉnh sửa thủ công trên Console để tránh xung đột với Terraform. Không chỉnh sửa file state bằng tay.
- Trường hợp resources đã tồn tại, có thể sử dụng import state từ local để không cần phải tạo lại. (Có thể dùng tool https://github.com/GoogleCloudPlatform/terraformer để tạo Terraform definition code)
- Naming convention, resources dùng **kebab-case**, variable dùng **snake_case**

# Đề mô

Mỗi môi trường một file state khác nhau (nên sử dụng account id làm prefix cho S3 để tránh trùng lặp)

## Chuẩn bị

```hcl
export TF_S3_BACKEND_BUCKET="$(aws sts get-caller-identity --query Account --output text)-tycloud-terraform"
export REGION=ap-southeast-1
export STAGE="dev"
aws s3 mb s3://${TF_S3_BACKEND_BUCKET} --region ${REGION}
terraform init -backend-config "bucket=${TF_S3_BACKEND_BUCKET}" -backend-config "key=${STAGE}/terraform.tfstate" -backend-config "region=${REGION}"
```

## Tạo resources

```hcl
terraform plan -var-file=${TF_VAR_FILE:-$STAGE.tfvars} -out=${STAGE}.tfplan
terraform apply -input=false ${TF_VAR_FILE:-$STAGE}.tfplan
```

## Xóa resources

```hcl
terraform plan -destroy -var-file=${TF_VAR_FILE:-$STAGE.tfvars} -out=${STAGE}.tfplan
terraform apply -destroy -input=false ${TF_VAR_FILE:-$STAGE}.tfplan
```

## Tham khảo

https://cloudacademy.com/blog/managed-nat-gateway-aws/