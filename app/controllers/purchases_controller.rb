class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    @listing = Listing.find(params[:listingId])
  end

  def webhook
    payment_intent_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
    listing_id = payment.metadata.listing_id
    buyer_id = payment.metadata.user_id

    Purchase.create(
      user_id: buyer_id,
      listing_id: listing_id,
      payment_intent_id: payment_intent_id,
      receipt_url: payment.charges.data[0].receipt_url
    )

    listing = Listing.find(listing_id)
    listing.update(status: 3)
  end

  def buy
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      line_items:[{
        amount: (@listing.price * 100).to_i,
        name: (@listing.year + ' ' + @listing.make + ' ' + @listing.model),
        currency: 'aud',
        quantity: 1,
        images: @listing.images.empty? ? nil : [@listing.images.first.service_url]
      }],
      payment_intent_data: {
        metadata: {
          listing_id: @listing.id,
          user_id: current_user.id
        }
      },
      success_url: "#{root_url}/purchases/success?listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
    )
    @session_id = stripe_session.id
  end

end
