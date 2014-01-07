require 'base64'
module OrdersHelper
  def encode_id(id)
    nid = id.to_s
    id = Base64.encode64(nid)
  end
end