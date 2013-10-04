require "tire"
module Tire
 class Index
   def get_id_from_document(document) #document is the object. ie agent object in the above case
     case 
       when document.is_a?(Hash)
         document[:_id] || document['_id'] || document[:id] || document['id']
      #if is not an hash and responds to 'id' and object_id is not equal to id "Agent.last.object_id => 96643940"
       when document.respond_to?(:id) && document.id != document.object_id
         document.id.to_s   # was document.id.as_json
       end
     end
   end
end