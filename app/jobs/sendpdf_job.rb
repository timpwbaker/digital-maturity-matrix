class SendpdfJob < ActiveJob::Base
  queue_as :default
  def perform(username, userid, useremail,matrixid,submissionid)
    Pony.delay.mail(
      :to => useremail, 
      :from => 'info@digitalmaturity.co.uk', 
      :subject => 'Here’s your Third Sector Digital Maturity Matrix', 
      :html_body => '<h2>Hello '+ username+'.</h2>
        <p> Your Maturity Matrix is attached. We hope you find this useful.
        <p> We’d love to know what you think, so please email <a href="mailto:digital@breastcancercare.org.uk">digital@breastcancercare.org.uk</a> with any feedback or questions.
        <p >All the best
        <p> Breast Cancer Care Digital Team', 
      :attachments => {
        "matrix.pdf" => File.read("pdfs/submission#{userid}.pdf")
      }
    );
  end
end
