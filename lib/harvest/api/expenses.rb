module Harvest
  module API
    class Expenses < Base
      api_model Harvest::Expense
      include Harvest::Behavior::Crud

      def attach(expense, filename, receipt)
        body = ""
        body << "--__X_ATTACH_BOUNDARY__\r\n"
        body << %Q{Content-Disposition: form-data; name="expense[receipt]"; filename="#{filename}"\r\n}
        body << "\r\n#{receipt.read}"
        body << "\r\n--__X_ATTACH_BOUNDARY__--\r\n\r\n"

        request(
          :post,
          credentials,
          "#{api_model.api_path}/#{expense.id}/receipt",
          :headers => {
            'Content-Type' => 'multipart/form-data; charset=utf-8; boundary=__X_ATTACH_BOUNDARY__',
            'Content-Length' => body.length.to_s,
          },
          :body => body)
      end
    end
  end
end
