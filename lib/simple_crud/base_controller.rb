require_relative 'helper/model_helper'
require_relative 'helper/decorator_helper'

module SimpleCrud
  class BaseController < ::ApplicationController
    include ModelHelper
    include DecoratorHelper

    before_filter :find_model, :only => [:show, :edit, :update, :destroy]
    respond_to :html, :json

    class << self
      attr_accessor :model_klass

      def crud_for(klass)
        @model_klass = klass
      end

      def default_crud
        matches = self.to_s.match /(?<name>.*)Controller/
        klass = matches[:name].singularize.constantize
        crud_for(klass)
      end
    end

    # GET /models
    # GET /models.json
    def index
      models_set model_klass.all
      respond_with models
    end

    # GET /models/1
    # GET /models/1.json
    def show
      respond_with model
    end

    # GET /models/new
    # GET /models/new.json
    def new
      model_set model_klass.new
      respond_with model
    end

    # GET /models/1/edit
    def edit
    end

    # POST /models
    # POST /models.json
    def create
      model_set model_klass.new(model_params)

      respond_to do |wants|
        if model.save
          flash[:notice] = t 'messages.record_created', model: t("models.#{model_name}")
          wants.html { redirect_to(model) }
          wants.json  { render :json => model, :status => :created, :location => model }
        else
          wants.html { render :action => "new" }
          wants.json  { render :json => model.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /models/1
    # PUT /models/1.json
    def update
      respond_to do |wants|
        if model.update_attributes(model_params)
          flash[:notice] = t 'messages.record_updated', model: t("models.#{model_name}")
          wants.html { redirect_to(model) }
          wants.json  { head :ok }
        else
          wants.html { render :action => "edit" }
          wants.json  { render :json => model.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /models/1
    # DELETE /models/1.json
    def destroy
      model.destroy
      flash[:notice] = t 'messages.record_destroyed', model: t("models.#{model_name}")

      respond_to do |wants|
        wants.html { redirect_to(models_path) }
        wants.json  { head :ok }
      end
    end

    private

    def find_model
      model_set model_klass.find(params[:id])
    end
  end
end
