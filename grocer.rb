def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  i = 0   
  
    while i < collection.length do 
      
      if name == collection[i][:item] #look for the matched item with the name key 
       return collection[i] # return the matched item 
       
      else 
       puts nil 
        i += 1 
      end 
      
    end 
    
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  j = 0 
  my_cart = []
    while j < cart.length do
      item_what_we_want = find_item_by_name_in_collection(cart[j][:item], my_cart)
      
      if item_what_we_want != nil
        item_what_we_want[:count] += 1 
      else 
        item_what_we_want = {
          :item => cart[j][:item],
          :price => cart[j][:price],
          :clearance => cart[j][:clearance],
          :count => 1
        }
        my_cart << item_what_we_want
       end  
        j += 1 
     end  
      
    my_cart
        
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  


#  cart is an AOH that [
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
#   {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
# ]

# #coupons is an array and this array should be [{:item => "AVOCADO", :num => 2, :cost => 5.00}] use the find_item_by_name_in_collection method to find the new_item 
# output should be an AOH and if the new_item exists, the new_item price => cost/num. round(2) item => :item + "W/COUPON"}
#[
#   {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 1},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 1},
#   {:item => "AVOCADO W/COUPON", :price => 2.50, :clearance => true, :count => 2}
# ]
# below code doesn't work
# items_with_coupon = []
# i = 0 
#   while i < cart.length do 
#     new_item = find_item_by_name_in_collection(cart[i][:item],items_with_coupon)
#     coupons_index = 0 
      
#       while coupons_index < coupons.length do 
#         if coupons[coupons_index][:item] == new_item[:item] && coupons[coupons_index][:num] == new_item[:count]
#           new_item = {
#             :item => "new_item[:item] +  W/COUPON"
#             :price => coupons[coupons_index][:cost]/coupons[coupons_index][:num].round(2),
#             :clearance => new_item[:clearance],
#             :count => new_item[:count]
#           }
#         items_with_coupon << new_item
#         end 
#         coupons_index += 1 
#       end 
#     i += 1 
#   end 
#   items_with_coupon
 
i = 0 
  while i < coupons.length do 
    items_with_coupon_in_cart = find_item_by_name_in_collection(coupons[i][:item], cart)
    
# all items in this array could be use coupon but need to check if meet the num 
    
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    
# inside the output array, if the item used the coupon, the name should be updated to couponed_item_name
    
    items_with_coupon_in_cart_name_updates = find_item_by_name_in_collection(couponed_item_name, cart)
    
# this array will change the couponed items to have the updated name in the cart array 
    
     if items_with_coupon_in_cart && items_with_coupon_in_cart[:count] >= coupons[i][:num]
# will get the array, all items are good for applying coupon 
        
        if items_with_coupon_in_cart_name_updates 

         items_with_coupon_in_cart_name_updates [:count] += coupons[i][:num]
         items_with_coupon_in_cart[:count] -= coupons[i][:num]
# the rest of the items who do not meet the num will be minus from the count          
         
        else 
         items_with_coupon_in_cart_name_updates = {
             :item => couponed_item_name,
             :price => coupons[i][:cost] / coupons[i][:num].round(2),
             :clearance => items_with_coupon_in_cart[:clearance],
             :count => coupons[i][:num]
          }
        
        cart << items_with_coupon_in_cart_name_updates
        items_with_coupon_in_cart[:count] -=coupons[i][:num]
        end 
      end 
      i += 1 
    end 
    
    cart

end

def apply_clearance(cart)

#  [
#   {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
#   {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
# ]


# it should update the cart with clearance applied to PEANUT BUTTER and SOY MILK:


# [
#   {:item => "PEANUT BUTTER", :price => 2.40, :clearance => true,  :count => 2},
#   {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
#   {:item => "SOY MILK", :price => 3.60, :clearance => true,  :count => 1}
# ]

# The `Float` class' built-in [round][round] method will be helpful here to make
# sure your values align. `2.4900923090909029304` becomes `2.5` if we use it
# like so: `2.4900923090909029304.round(2)`

# need to loop the cart to check each items if has clearance => true 
# if true, update the price to 
# new_price = clearance_cart[:price] * (1-20%).round(2)



i = 0 
  while i < cart.length do 
    if cart[i][:clearance] == true
      cart[i][:price] = (cart[i][:price] * (1-0.2)).round(2)
    end 
    i += 1
  end 
  cart 
end

def checkout(cart, coupons)
 
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  

# * Returns:
#   * `Float`: a total of the cart

# Here's where we stitch it all together. Given a "cart" `Array`, the first
# argument, we should first create a new consolidated cart using the
# `consolidate_cart` method.

# We should pass the newly consolidated cart to `apply_coupons` and then send it to
# `apply_clearance`. With all the discounts applied, we should loop through the
# "consolidated and discounts-applied" cart and multiply each item Hash's price
# by its count and accumulate that to a grand total.

# As one last wrinkle, our grocery store offers a deal for customers buying lots
# of items. If, after the coupons and discounts are applied, the cart's total is
# over $100, the customer gets an additional 10% off. Apply this discount when
# appropriate.


# my_cart represents all the items what we purchased from  cart using the method consolidate_cart
# apply the apply_coupons method to update my_cart which change the couponed items price with the correct prices
# apply the apply_clearance method to update my_cart which change the clearanced items price with the correct prices
# get sum from the my_cart[:price] using the loop in my_cart.length
# check if sum > 100, total will be sum * 0.9 , else return sum 


my_cart = consolidate_cart (cart)
my_cart = apply_coupons(my_cart, coupons)
my_cart = apply_clearance(my_cart)

i = 0 
sum = 0 
  while i < my_cart.length do 
    sum += my_cart[i][:price] * my_cart[i][:count]
    i += 1 
  end 
  
    if sum > 100 
      sum = sum * 0.9 
    else
    sum 
    end
sum 
end




