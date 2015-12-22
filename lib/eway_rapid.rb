# eWAY Rapid API Ruby Module
require 'json'
require 'rest-client'
require 'yaml'

require File.join(File.dirname(__FILE__), 'eway_rapid', 'version')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'constants')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'exceptions')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'rapid_logger')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'rapid_client')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'models', 'enums')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'models', 'models')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'models', 'internal_models')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'output', 'response_output')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'output', 'create_transaction_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'output', 'query_customer_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'output', 'query_transaction_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'output', 'refund_response')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'cancel_authorisation_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'cancel_authorisation_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'capture_payment_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'capture_payment_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'create_access_code_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'create_access_code_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'create_access_code_shared_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'create_access_code_shared_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'create_customer_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_customer_search_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_customer_search_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_payment_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_payment_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_refund_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'direct_refund_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'entities', 'transaction_search_response')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'customer_to_internal_customer')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'direct_payment_to_trans_status')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'direct_refund_to_trans_status')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'internal_customer_to_customer')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'internal_trans_to_trans')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'internal_transaction_to_address')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'internal_transaction_to_status')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'payment_to_payment_details')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'shipping_details_to_address')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'transaction_shipping_address')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'transaction_to_arr_line_item')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'transaction_to_arr_option')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'transaction_to_payment')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'verification_to_verification_result')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'request', 'refund_to_direct_refund_req')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'request', 'transaction_to_capture_payment')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'request', 'transaction_to_create_access_code_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'request', 'transaction_to_create_access_code_shared_request')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'request', 'transaction_to_direct_payment')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'access_code_shared_to_create_cust')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'access_code_shared_to_create_trans')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'access_code_to_create_cust')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'access_code_to_create_trans')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'cancel_authorisation_to_refund')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'capture_payment_to_create_transaction')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'direct_customer_to_query_customer')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'direct_payment_to_create_cust')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'direct_payment_to_create_trans')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'direct_refund_to_refund_response')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'convert', 'response', 'search_to_query_trans')

require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'process', 'rest_process')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'process', 'customer_process')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'process', 'refund_process')
require File.join(File.dirname(__FILE__), 'eway_rapid', 'message', 'process', 'transaction_process')

module EwayRapid
end
