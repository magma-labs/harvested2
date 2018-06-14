module Harvest
  class Expense < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    api_path '/expenses'

    delegate_methods(billed?: :is_billed,
                     closed?: :is_closed)

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.receipt = args.delete('receipt') if args['receipt']
      self.user = args.delete('user') if args['user']
      self.project = args.delete('project') if args['project']
      self.client = args.delete('client') if args['client']
      self.spent_date = args.delete('spent_date') if args['spent_date']
      self.user_assignment = args.delete('user_assignment') if args['user_assignment']
      self.expense_category = args.delete('expense_category') if args['expense_category']
      super
    end

    def receipt=(receipt)
      self['receipt_id'] = receipt['id']
      self['receipt_file_name'] = receipt['file_name']
      self['receipt_file_size'] = receipt['file_size']
      self['receipt_content_type'] = receipt['content_type']
    end

    def user=(user)
      self['user_id'] = user['id']
    end

    def project=(project)
      self['project_id'] = project['id']
    end

    def client=(client)
      self['client_id'] = client['id']
    end

    def spent_date=(date)
      self['spent_date'] = Date.parse(date.to_s)
    end

    def user_assignment=(user_assignment)
      self['user_assignment_id'] = user_assignment['id']
    end

    def expense_category=(expense_category)
      self['expense_category_id'] = expense_category['id']
    end
  end
end
