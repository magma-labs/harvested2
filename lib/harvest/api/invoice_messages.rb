module Harvest
  module API
    class InvoiceMessages < Base
      api_model Harvest::InvoiceMessage

      def all(invoice, query = {})
        response = request(:get, credentials, "/invoices/#{invoice.id}/messages", query: query)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'] > 1
          counter = response_parsed['page']

          while counter <= response_parsed['total_pages'] do
            counter += 1
            query = { 'page' => counter }

            response_page = request(:get, credentials,
              "/invoices/#{invoice.id}/messages",
              query: query)
            invoice_messages = api_model.to_json(response.parsed_response)
            response_parsed['invoice_messages']
              .concat(invoice_messages['invoice_messages'])
          end
        end

        api_model.parse(response_parsed)
      end

      def create(invoice, invoice_message)
        invoice_message = api_model.wrap(invoice_message)
        response = request(:post, credentials, "/invoices/#{invoice.id}/messages", body: invoice_message.to_json)
        find(invoice_message.id)
      end

      def delete(invoice, invoice_message)
        request(:delete, credentials, "/invoices/#{invoice.id}/messages/#{invoice_message.id}")
        message.id
      end

      # Create a message for marking an invoice as sent.
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_sent(invoice, invoice_message)
        send_status_message(invoice, invoice_message, 'send')
      end

      # Create a message and mark an open invoice as closed (writing an invoice off)
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_closed(invoice, invoice_message)
        send_status_message(invoice, invoice_message, 'close')
      end

      # Create a message and mark a closed (written-off) invoice as open
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def re_open(invoice, invoice_message)
        send_status_message(invoice, invoice_message, 're-open')
      end

      # Create a message for marking an open invoice as draft
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_draft(invoice_message)
        send_status_message(invoice, invoice_message, 'draft')
      end

      private

      def send_status_message(invoice, invoice_message, action)
        invoice_message = api_model.wrap(invoice_message)
        response = request( :post,
                            credentials,
                            "/invoices/#{invoice.id}/messages",
                            event_type: action,
                            body: invoice_message.to_json)

        invoice_message
      end
    end
  end
end
