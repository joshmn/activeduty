module ActiveDuty
  module Initializers
    module InitModels
      # init_models order_id:    Order
      #                          => Order.find(order_id)
      # init_models order_ids:   Order
      #                          => Order.where(id: order_ids)
      # init_models order_token: Order.find_by(token: order_token)
      #                          => Order.find_by(token: order_token)
      # init_models product_id:  LineItem
      #                          => LineItem.where(product_id: product_id)
    end
  end
end
