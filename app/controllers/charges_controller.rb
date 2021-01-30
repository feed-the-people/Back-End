class ChargesController < ApplicationController
  def create
    amount = params[:amount].delete('.')

    customer = Stripe::Customer.create({
      name: params[:name],
      email: params[:email],
      source: params[:charge][:token]
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: amount,
      description: 'NPO Donation',
      currency: 'usd',
      metadata: {
        npo_ein: params[:npoEin],
        npo_name: params[:npoName]
      }
    })

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
