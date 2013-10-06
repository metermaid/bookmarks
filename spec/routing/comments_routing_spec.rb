require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #edit" do
      get("/bookmarks/1/comments/1/edit").should route_to("comments#edit", :bookmark_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/bookmarks/1/comments").should route_to("comments#create", :bookmark_id => "1")
    end

    it "routes to #update" do
      put("/bookmarks/1/comments/1").should route_to("comments#update", :bookmark_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bookmarks/1/comments/1").should route_to("comments#destroy", :bookmark_id => "1", :id => "1")
    end

  end
end
