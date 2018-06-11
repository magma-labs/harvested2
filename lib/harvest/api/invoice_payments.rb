module Harvest
  module API
    class InvoicePayments < Base
      api_model Harvest::InvoicePayment

      def all(invoice, query = {})
        response = request(:get, credentials, "/invoices/#{invoice.id}/payments", query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'].to_i > 1
          counter = response_parsed['page'].to_i

          while counter <= response_parsed['total_pages'].to_i do
            counter += 1
            query = { 'page' => counter }

            response_page = request(:get, credentials,
              "/invoices/#{invoice.id}/payments",
              query: query)
            invoice_payments = api_model.to_json(response.parsed_response)
            response_parsed['invoice_payments']
              .concat(invoice_payments['invoice_payments'])
          end
        end

        api_model.parse(response_parsed)
      end

      def create(invoice, invoice_payment)
        invoice_payment = api_model.wrap(invoice_payment)
        response = request(:post, credentials, "/invoices/#{invoice.id}/payments", body: invoice_payment.to_json)
        find(invoice_payment.id)
      end

      def delete(invoice, invoice_payment)
        request(:delete, credentials, "/invoices/#{invoice.id}/payments/#{invoice_payment.id}")
        invoice_payment.id
      end
    end
  end
end
