namespace :pdfs do
  desc "TODO"
  task generate_pdfs: :environment do

submissions = Submission.all
    submissions.all.each do |sub|
      @matrix = Matrix.find(sub.matrix_id)
      @user = User.find(sub.user_id)
      @submission = Submission.find(sub.id)
      create_and_save_pdf
    end

  end

  end
end

