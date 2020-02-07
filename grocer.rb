def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  thing = 0
     while thing < collection.length do
      if name == collection[thing][:item]
        return collection[thing]
      end
      thing +=1
    end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
   consolidated_cart = []
    thing = 0
    while thing < cart.length do
      if (find_item_by_name_in_collection(cart[thing][:item], consolidated_cart) == nil)
        cart[thing][:count] = 1
        consolidated_cart << cart[thing]
      else
        find_item_by_name_in_collection(cart[thing][:item], cart)[:count] +=1
      end
      thing +=1
    end
    consolidated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   coupon_index = 0
  while coupon_index < coupons.length do
    coupon_item_present = find_item_by_name_in_collection(coupons[coupon_index][:item], cart) 
    if ( coupon_item_present[:count] / coupons[coupon_index][:num] >= 1 )
      cart.push ( {:item => "#{coupons[coupon_index][:item]} W/COUPON",
               :price => (coupons[coupon_index][:cost] / 
              coupons[coupon_index][:num]).round(2),
              :clearance => coupon_item_present[:clearance],
              :count => coupon_item_present[:count] - (coupon_item_present[:count] % coupons[coupon_index][:num])
             })

             coupon_item_present[:count] %= coupons[coupon_index][:num]
            end
            coupon_index +=1
          end
          cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   cart_with_clearance = []
  cart_index = 0
  while cart_index < cart.length do
    if cart[cart_index][:clearance]
      cart[cart_index][:price] = cart[cart_index][:price] - (cart[cart_index][:price] * 0.20)
    end
    cart_with_clearance << cart[cart_index]
    cart_index +=1
  end
  cart_with_clearance
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
    consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  i = 0
  grand_total = 0
  while i < clearanced_cart.count do
    item_price = clearanced_cart[i][:price] * clearanced_cart[i][:count]
    item_price.round(2)
    grand_total += item_price
    i +=1
    end
    if grand_total > 100
      grand_total *= 0.90
     end
    grand_total.round(2)
end
