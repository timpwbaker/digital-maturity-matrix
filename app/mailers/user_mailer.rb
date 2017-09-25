class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to the Digital Maturity Matrix")
  end

  def matrix_pdf(user, file_url)
    @user = user
    attachments['digital-maturity-matrix.pdf'] = open(file_url).read
    mail(
      to: @user.email,
      subject: "Your Digital Maturity Matrix"
    )
  end
end
