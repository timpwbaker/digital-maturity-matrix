module Reports

  class Submissions
    attr_reader :submissions
    attr_reader :questions
    attr_reader :targets
    attr_reader :answers
    attr_reader :users

    def initialize(submissions)
      @submissions = submissions
    end

    def generate
      CSV.generate do |csv|
        csv << column_names
        Submissions.each do |submission|
          row = []

          row[0] = submission.id
          Questions.each_with_index do |question, index|
            answer = Answer.where(submission_id: submission.id).where(question_id: question_id)
            target = Target.where(submission_id: submission.id).where(question_id: question_id)
            row[ (index*2) - 1 ] = answer.choice
            row[ (index*2)] = target.choice

          end
          
          # row[4] = user.last_name

          # if user.address
          #   row[5] = user.address.street
          #   row[6] = user.address.city
          #   row[7] = user.address.state
          #   row[10] = user.address.postcode
          # end

          # row[12] = "'#{user.mobile}'"
          # row[13] = user.email
          # row[17] = user.date_of_birth
          # row[21] = user.next_of_kin_name
          # row[23] = "'#{user.next_of_kin_contact}'"
          # row[36] = user.ni_number
          # row[44] = user.created_at

          # if user.bank_detail
          #   row[62] = "'#{user.bank_detail.sort_code}'"
          #   row[63] = "'#{user.bank_detail.account_number}'"
          #   row[64] = user.bank_detail.account_holder
          #   row[68] = user.bank_detail.bank_name
          # end

          # row[169] = user.employee_statement
          # row[170] = user.student_loans

          csv << row
        end
      end
    end

    private

    def column_names
      column_headers = ['submission id']

      Questions.each do |question|
        column_headers << "Current: #{question.body}"
        column_headers << "Target: #{question.body}"
      end

      return column_names
      #['Employee Reference', 'Title', 'Initial', 'Forename', 'Surname', 'Address 1', 'Address 2', 'Address 3', 'Address 4', 'Address 5', 'Post Code', 'Telephone Number', 'Mobile Number', 'E-mail Address', 'Gender', 'Marital Status', 'Previous Surname', 'Date of Birth', 'Disabled', 'Nationality', 'Ethnic Origin', 'Contact', 'Contact Relationship', 'Contact Telephone No.', 'Contact Address 1', 'Contact Address 2', 'Contact Address 3', 'Contact Address 4', 'Contact Address 5', 'Contact Postcode', 'Contact Mobile', 'Contact Email', 'Tax Code', 'Wk1Mth1 Basis', 'NI Category', 'Manual NIC', 'NI Number', 'Starter Form', 'Welfare To Work', 'Works Reference', 'Director Status', 'Date Directorship Began', 'Payment Method', 'Payment Frequency', 'Work Start Date', 'Work End Date', 'SLR From Date', 'SLR to Date', 'Minimum Wage Check', 'Non UK Worker', 'Apprentice', 'Status', 'Gross Salary', 'Salary Per Period', 'Contracted Hours', 'Contracted Hours Per Period', 'Pension 1', 'Pension 2', 'Pension 3', 'Pension 4', 'Pension 5', 'Holiday Scheme', 'Sort Code', 'Bank Account Number', 'Bank Account Name', 'Bank Account Type', 'Building Soc Number', 'BACS Reference', 'Bank Name', 'Bank Address 1', 'Bank Address 2', 'Bank Address 3', 'Bank Address 4', 'Bank Address 5', 'Bank Post Code', 'Bank Telephone', 'Bank Fax', 'Department Reference', 'Cost Centre Reference', 'Notes' 'Access Level', 'Analysis 1', 'Analysis 2', 'Analysis 3', 'Last Processed Date', 'Final Pay Run', 'Manual SSP', 'SSP QD Pattern Start Date', 'SSP Band', 'Start PIW Date', 'End PIW Date', 'SSP Waiting Days', 'Returned to Work Date', 'Manual SMP', 'SMP EWC', 'SMP Date of Birth', 'SMP End Work Date', 'SMP Returned to Work Date', 'SMP Weeks Worked MPP', 'SMP Weeks Trade Dispute', 'SMP Average Gross Pay', 'SMP Medical Evidence', 'SMP Pregnancy Related sickness', 'Manual SAP', 'SAP Matching Date', 'SAP Expected Date of Placement', 'SAP Actual Date of Placement', 'SAP End Work Date', 'SAP Returned to Work Date', 'Weeks Worked during SAP', 'SAP Weeks Trade Dispute', 'SAP Average Gross Pay', 'SAP Evidence', 'Manual SPP', 'SPP Baby Due Date', 'SPP Date of Birth', 'SPP End Work Date', 'SPP Returned to Work Date', 'Weeks Worked during SPP', 'SPP Weeks Trade Dispute', 'SPP Average Gross Pay', 'SPP Declaration Received', 'ASPP Declaration Received', 'ASPP Mother Declaration', 'ASPP Start Date for MPP', 'ASPP Ended Work Date', 'ASPP Returned to Work Date', 'ASPP Started by death', 'ASPP KIT Days Worked', 'Weeks Worked during APPP', 'Manual SPPA', 'SPPA Matching Date', 'SPPA Expected Date of Placement', 'SPPA Actual Date of Placement', 'SPPA End Work Date', 'SPPA Returned to Work Date', 'Weeks Worked during SPPA', 'SPPA Weeks Trade Dispute', 'SPPA Average Gross Pay', 'SPPA Declaration Received', 'ASPPA Declaration Received', 'ASPPA Co-Adopter Declaration', 'ASPPA Start Date for APP', 'ASPPA Ended Work Date', 'ASPPA Returned to Work Date', 'ASPPA Started by death', 'ASPPA KIT Days Worked', 'Weeks Worked during APPPA', 'Job Title', 'Employment Type', 'Payroll ID', 'IBAN', 'BIC', 'Second Bank Sort Code', 'Second Bank Account Number', 'Second Bank Account Name', 'Second Bank Account Type', 'Second Building Soc Number', 'Second BACS Reference', 'Second Bank Name', 'Second Bank Address 1', 'Second Bank Address 2', 'Second Bank Address 3', 'Second Bank Address 4', 'Second Bank Address 5', 'Second Bank Postcode', 'Second Bank Telephone', 'Second Bank Fax', 'Second Bank Account IBAN', 'Second Bank Account BIC', 'Employee statement', 'Student loans']
    end
  end

   end