require_relative 'helper/resource_helper'
require_relative 'helper/decorator_helper'

module SimpleCrud
  class BaseController < ::ApplicationController
    include DecoratorHelper
    include ResourceHelper

    before_filter :find_resource, :only => [:show, :edit, :update, :destroy]
    respond_to :html, :json

    class << self
      attr_accessor :resource_klass

      def crud_for(klass)
        @resource_klass = klass
      end

      def default_crud
        matches = self.to_s.match /(?<name>.*)Controller/
        klass = matches[:name].singularize.constantize
        crud_for(klass)
      end
    end

    # GET /resources
    # GET /resources.json
    def index
      resources_set resource_klass.all
      respond_with resources_get
    end

    # GET /resources/1
    # GET /resources/1.json
    def show
      respond_with resource_get
    end

    # GET /resources/new
    # GET /resources/new.json
    def new
      resource_set resource_klass.new
      respond_with resource_get
    end

    # GET /resources/1/edit
    def edit
    end

    # POST /resources
    # POST /resources.json
    def create
      resource_set resource_klass.new(resource_params)

      respond_to do |wants|
        result = resource_get.save
        call_hook :after_save, result
        if result
          flash[:notice] = t 'messages.record_created', resource: t("models.#{resource_name}")
          wants.html { redirect_to(resource_get) }
          wants.json  { render :json => resource_get, :status => :created, :location => resource }
        else
          wants.html { render :action => "new" }
          wants.json  { render :json => resource_get.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /resources/1
    # PUT /resources/1.json
    def update
      respond_to do |wants|
        result = resource_get.update_attributes(resource_params)
        call_hook :after_update_attributes, result
        if result
          flash[:notice] = t 'messages.record_updated', resource: t("models.#{resource_name}")
          wants.html { redirect_to(resource_get) }
          wants.json  { head :ok }
        else
          wants.html { render :action => "edit" }
          wants.json  { render :json => resource_get.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /resources/1
    # DELETE /resources/1.json
    def destroy
      result = resource_get.destroy
      call_hook :after_destroy, result
      flash[:notice] = t 'messages.record_destroyed', resource: t("models.#{resource_name}")

      respond_to do |wants|
        wants.html { redirect_to(resources_path) }
        wants.json  { head :ok }
      end
    end

    private

    def find_resource
      resource_set resource_klass.find(params[:id])
    end

    def call_hook(method, *args)
      send(method, *args) if respond_to? method
    end

  end
end
