# platform-opensearch-cloudwatch

This module is designed to be used by anyone with an AWS OpenSearch domain to easily set up Cloudwatch monitoring.  

Default thresholds and period lengths should be reasonable for most; however, most can be overridden as needed.  
Simple binary thresholds such as count >0 for "is the cluster red" or "is the cluster yellow" are not overridable.

The module has a single required input -- opensearch_domain, which must match the name of an opensearch domain existent 
in the AWS account/region in use.

Variable names for threshold and period overrides can be found in the code.

The module outputs the name of the SNS queue defined as a Cloudwatch topic; configuration of SNS email or Datadog 
subscriptions should be done in the calling module.
