def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  count = 0
  while count < collection.length  
   if collection[count][:item] == name
    return collection[count]
  end
    count += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
count = 0
new_cart = []  
while count < cart.length
new_veg = find_item_by_name_in_collection(cart[count][:item], new_cart)
  if new_veg != nil
    new_veg[:count] += 1
  else
  new_veg = {
    :item => cart[count][:item],
    :price => cart[count][:price],
    :clearance => cart[count][:clearance],
    :count => 1
  }
  new_cart << new_veg
end
    count += 1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  count = 0
  while count < coupons.length  
  veggie = find_item_by_name_in_collection(coupons[count][:item], cart)
  veg_w_coup = "#{coupons[count][:item]} W/COUPON"
  couponed_veg = find_item_by_name_in_collection(veg_w_coup, cart)
      if veggie && veggie[:count] >= coupons[count][:num]
        if couponed_veg
          couponed_veg[:count] += coupons[count][:num]
          veggie[:count] -= coupons[count][:num]
        else
          couponed_veg = {
            :item => veg_w_coup,
            :price => coupons[count][:cost] / coupons[count][:num],
            :count => coupons[count][:num],
            :clearance => veggie[:clearance]
          }
          cart << couponed_veg
          veggie[:count] -= coupons[count][:num]
        end
    end  
      count += 1
    end
    cart
  end

def apply_clearance(cart)
count = 0
while count < cart.length
if cart[count][:clearance]
  discount = cart[count][:price]
  cart[count][:price] = (discount - (discount * 0.20)).round(2)
    end
  count += 1
end
cart
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
  new_cart = consolidate_cart(cart)
  xtreme_coupon = apply_coupons(new_cart, coupons)
  finalcart = apply_clearance(xtreme_coupon)
  price = 0
i = 0 
while i < finalcart.length
price += finalcart[i][:price] * finalcart[i][:count]
  i += 1
end
if price > 100
  price -= (price * 0.10)
end
price
end

