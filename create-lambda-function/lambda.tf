data "archive_file" "init"{
    type = "zip"
    source_file = "unused-eips.py"
    output_path = "unused-eips.zip"
}

resource "aws_lambda_function" "unused_eips"{
    filename = data.archive_file.init.output_path
    function_name = "unused-eips-send-email"
    role = aws_iam_role.Unused_EIP_Role.arn
    handler = "unused-eips.lambda_handler"

    # If no changes to the script then do not deploy
    source_code_hash = filebase64sha256(data.archive_file.init.output_path)

    runtime = "python3.8"
    environment {
        variables = {
            SOURCE_EMAIL = var.source_email,
            DEST_EMAIL = var.dest_email
        }
    }
}


# Schedule Lambda Function
resource "aws_cloudwatch_event_rule" "unused_eips_rule"{
    name = "unused_eips_rule"
    description = "find unused eips"
    schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "unused_eips_target"{
    rule = aws_cloudwatch_event_rule.unused_eips_rule.name
    target_id = "SendUnusedEIPToEmail"
    arn = aws_lambda_function.unused_eips.arn
}

# Trigger Lambda Function
resource "aws_lambda_permission" "allow_cloudwatch"{
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.unused_eips.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.unused_eips_rule.arn
}
