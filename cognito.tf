resource "aws_cognito_user_pool" "main" {
  name = "menuguru-auth"
  
  alias_attributes  = ["email"]
  
  password_policy {
  	minimum_length   = 11
  	require_numbers  = true
  }
  
  mfa_configuration  = "OFF"
  
  account_recovery_setting {
  	recovery_mechanism {
  		name      = "admin_only"
  		priority  = 1
  	}  	
  }
  
  schema {
    name = "id"
    attribute_data_type = "Number"
    required = false
    mutable = true
  }
  
  schema {
    name = "email"
    attribute_data_type = "String"
    required = true
    mutable = true
  }  
  
  schema {
    name = "given_name"
    attribute_data_type = "String"
    required = true
    mutable = true
  }
  
  email_configuration {
  	email_sending_account  = "COGNITO_DEFAULT"
  }
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "menuguru-auth"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "client" {
  name = "menuguru-app"

  user_pool_id = aws_cognito_user_pool.main.id
  
  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  
  generate_secret     = true
  callback_urls       = ["https://example.com"]
}