module Spree
  module Admin
    class PollsController < ResourceController

      before_filter :build_answers, only: :new 

      def index
        session[:return_to] = request.url
        respond_with(@collection)
      end

      def show
        session[:return_to] ||= request.referer
        redirect_to( :action => :edit )
      end

      private
        def build_answers
          2.times { @poll.poll_answers.build }
        end

        def collection
          return @collection if @collection.present?
          params[:q] ||= {}

          params[:q][:s] ||= "name asc"

          @search = super.ransack(params[:q])

          @collection = @search.result.
            page(params[:page]).
            per(Spree::Suffrage::Config[:admin_polls_per_page])
          @collection
        end

        def permitted_resource_params
          params.require(:poll).permit(:name, :question, :allow_view_results_without_voting, poll_answer_attributes: [:answer])
        end
    end
  end
end
