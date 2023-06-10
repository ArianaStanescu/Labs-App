class OrderMailer < ApplicationMailer
  require 'wicked_pdf'
  layout 'mailer'
  default from: "orders@gemstone_paradise.com"
  def send_email(user, order)
    @product = order.product
    @order = order
    attachments['invoice.pdf'] = generate_pdf_invoice
    mail(to: user.email, subject: 'Order Placed!')
  end
  private

  def generate_pdf_invoice
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(
        # template: Rails.root.join('order_mailer', 'invoice_pdf.html.erb').to_s
        template: 'order_mailer/invoice_pdf'.to_s
      )
    )
    pdf
  end
end
