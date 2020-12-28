module Api
  module V1
    class ShippingsController < ApplicationController
      protect_from_forgery with: :null_session

      # GET /api/v1/shippings
      def index
        render json: serializer(shippings, options)
      end
      
      # GET /api/v1/shippings/:slug
      def show
        render json: serializer(shipping, options)
      end

      # POST /api/v1/shippings
      def create
        shipping = Shipping.new(shipping_params)

        if shipping.save
          render json: serializer(shipping)
        else
          render json: errors(shipping), status: 422
        end
      end

      # PATCH /api/v1/shippings/:slug
      def update
        shipping = Shipping.find_by(slug: params[:slug])

        if shipping.update(shipping_params)
          render json: serializer(shipping, options)
        else
          render json: errors(shipping), status: 422
        end
      end

      # DELETE /api/v1/shippings/:slug
      def destroy
        if shipping.destroy
          head :no_content
        else
          render json: errors(shipping), status: 422
        end
      end

      private

      # Used For compound documents with fast_jsonapi
      def options
        @options ||= { include: %i[reviews] }
      end

      # Get all shippings
      def shippings
        @shipping ||= Shipping.includes(reviews: :user).all
      end

      # Get a specific shipping
      def airline
        @shipping ||= Shipping.includes(reviews: :user).find_by(slug: params[:slug])
      end

      # Strong params
      def shipping_params
        params.require(:shipping).permit(:name, :image_url)
      end

      # fast_jsonapi serializer
      def serializer(records, options = {})
        ShippingSerializer
          .new(records, options)
          .serialized_json
      end

      # Errors
      def errors(record)
        { errors: record.errors.messages }
      end
    end
  end
end