class PagesController < ApplicationController
	include HighVoltage::StaticPage

	before_filter :set_menuitem

	private
	def set_menuitem
		@menu_item = params[:id]
	end
end
