class DigestMailMailer < ApplicationMailer
    def new_email
        @orders = Order.where(updated_at: 24.hours.ago..Time.now).order(created_at: :asc)

        mail(to: 'carlos.balsas17@gmail.com', subject: "Digest Email")
    end
end
